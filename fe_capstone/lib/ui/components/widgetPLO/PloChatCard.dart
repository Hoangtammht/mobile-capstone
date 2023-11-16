import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ChatUser.dart';
import 'package:fe_capstone/models/Message.dart';
import 'package:fe_capstone/ui/helper/my_date_until.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../screens/ChatScreen.dart';

class PloChatCard extends StatefulWidget {
  final ChatUser user;

  const PloChatCard({super.key, required this.user});

  @override
  State<PloChatCard> createState() => _PloChatCard();
}

class _PloChatCard extends State<PloChatCard> {
  MessageCustom? _message;
  String userID = '';
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;
  @override
  void initState() {
    super.initState();
    getUserID();
    getStream();
  }

  void getUserID() async {
    String? name = await UserPreferences.getUserID();
    if (userID != null) {
      setState(() {
        userID = name!;
      });
    }
  }
  void getStream() async {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = await FirebaseAPI.getLastMessage(widget.user);
    if (data != null) {
      setState(() {
        stream = data!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: ChatScreen(user: widget.user, admin: false,),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: StreamBuilder(
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final _list =
                data?.map((e) => MessageCustom.fromJson(e.data())).toList() ??
                    [];
            if (_list.isNotEmpty) {
              _message = _list[0];
            }
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.user.name,
                        style: TextStyle(
                            fontSize: 16 * fem, fontWeight: FontWeight.bold),
                      ),
                      if (_message != null)
                        _message!.read.isEmpty && _message!.fromId != userID
                            ? Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent.shade400,
                              borderRadius: BorderRadius.circular(10)),
                        )
                            : Text(
                          MyDateUtil.getLastMessageTime(context: context, time: _message!.sent),
                          style: TextStyle(color: Colors.black54),
                        )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10 * fem),
                    child: Text(
                      _message != null
                          ? _message!.msg
                          : 'Hey, I booked a parking lot',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13 * fem,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  )
                ],
              ),
            );
          },
          stream: stream,
        ));
  }
}
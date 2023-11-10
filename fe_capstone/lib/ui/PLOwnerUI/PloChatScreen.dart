import 'dart:math';

import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ChatUser.dart';
import 'package:fe_capstone/ui/components/widgetPLO/PloChatCard.dart';
import 'package:flutter/material.dart';

class PloChatScreen extends StatefulWidget {
  const PloChatScreen({Key? key}) : super(key: key);

  @override
  State<PloChatScreen> createState() => _PloChatScreenState();
}

class _PloChatScreenState extends State<PloChatScreen> {
  List<ChatUser> list = [];
  String userID = '';

  @override
  void initState() {
    super.initState();
    getUserID();
  }

  void getUserID() async {
    String? name = await UserPreferences.getUserID();
    if (userID != null) {
      setState(() {
        userID = name!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'TIN NHẮN',
            style: TextStyle(
              fontSize: 26 * ffem,
              fontWeight: FontWeight.w700,
              height: 1.175 * ffem / fem,
              color: Color(0xffffffff),
            ),
          ),
        ),
        body:

        StreamBuilder(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                  list =  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
                if (list.isNotEmpty) {
                  return Container(
                    margin: EdgeInsets.only(top: 15 * fem),
                    child:
                    ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return PloChatCard(user: list[index]);
                        }),
                  );
                } else {
                  return Center (child: Text('Không có hộp thoại nào', style: TextStyle(fontSize: 20)));
                }
            }
          },
          stream: FirebaseAPI.getAllUser(userID),
        ));
  }
}

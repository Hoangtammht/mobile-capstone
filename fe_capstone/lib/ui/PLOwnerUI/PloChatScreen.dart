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
  List<ChatUser> users = [
    ChatUser(id: "1", name: "Hoang Tam", lastMessage: "Hello and smile", time: "3 phút trước"),
    ChatUser(id: "2", name: "Hoang Tam lun", lastMessage: "Mệt mỏi quá à", time: "15 phút trước"),
  ];


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
        body: Container(
          margin: EdgeInsets.only(top: 15 * fem),
          child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context,index){
                final user = users[index];
            return PloChatCard(user: user,);
          }),
        ),
    );
  }
}

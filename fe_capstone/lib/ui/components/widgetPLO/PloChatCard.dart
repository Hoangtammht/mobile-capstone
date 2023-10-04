import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ChatUser.dart';
import 'package:flutter/material.dart';

class PloChatCard extends StatelessWidget {
  final ChatUser user;
  const PloChatCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(user.name, style: TextStyle(
                fontSize: 16 * fem,
                fontWeight: FontWeight.bold
              ),),
              Text(user.time, style: TextStyle(
                  fontSize: 16 * fem,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey
              ),),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10 * fem),
            child: Text(user.lastMessage, style: TextStyle(
              color: Colors.grey,
              fontSize: 13 * fem,
            ),),
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

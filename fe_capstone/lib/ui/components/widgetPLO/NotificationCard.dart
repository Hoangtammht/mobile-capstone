import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/PLONotification.dart';
import 'package:fe_capstone/ui/helper/my_date_until.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final PLONotification notification;
  const NotificationCard({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(top: 5 * fem, bottom: 5 * fem),
        child: Column(
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Từ: ${notification.senderName}', style: TextStyle(
                    fontSize: 20 * fem,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(notification.content, style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20 * fem,
                    color: Colors.grey
                  ),),
                  Align(
                    alignment: Alignment.bottomRight,
                      child: Text(MyDateUtil.formatCheckInAndCheckOutDate(notification.createdAt), style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18 * fem,
                          color: Colors.grey
                      ),)),
                  Divider(
                    thickness: 0.8,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

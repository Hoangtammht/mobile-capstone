import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/PloNotification.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final PloNotification notification;
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
                  Text('Từ: ${notification.fromBy}', style: TextStyle(
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(notification.content, style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15 * fem,
                    color: Colors.grey
                  ),),
                  Align(
                    alignment: Alignment.bottomRight,
                      child: Text(notification.date, style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15 * fem,
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

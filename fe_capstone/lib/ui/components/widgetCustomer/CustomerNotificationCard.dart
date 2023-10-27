import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/CustomerNotification.dart';
import 'package:fe_capstone/ui/helper/my_date_until.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerNotificationCard extends StatelessWidget {
  final CustomerNotification notification;
  const CustomerNotificationCard({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 5 * fem, bottom: 5 * fem),
        child: ListTile(
          title: Row(
            children: [
              Container(
                width: 100 * fem,
                height: 60 * fem,
                child: Image.network(
                  'https://fiftyfifty.b-cdn.net/eparking/scaled_Screenshot_20231022-095624_Animal Puzzle.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8 * fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Từ: ${notification.senderName}',
                        style: TextStyle(
                            fontSize: 16 * fem, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        notification.content,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20 * fem,
                            color: Colors.grey),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            MyDateUtil.formatCheckInAndCheckOutDate(notification.createdAt.toString()),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20 * fem,
                                color: Colors.grey),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

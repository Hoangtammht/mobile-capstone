import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/PloNotification.dart';
import 'package:fe_capstone/ui/components/widgetPLO/NotificationCard.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List<PloNotification> getNotifications() {
    return [
      PloNotification(
        fromBy: 'Admin',
        content: 'Còn 1 tuần nữa là bãi xe của bạn sẽ đóng do hết hợp đồng. Chúng tôi sẽ liên hệ một cách sớm nhất để gia hạn hợp đồng.',
        date: '3 tiếng trước',
      ),
      PloNotification(
        fromBy: 'Admin',
        content: 'Còn 1 tuần nữa là bãi xe của bạn sẽ đóng do hết hợp đồng. Chúng tôi sẽ liên hệ một cách sớm nhất để gia hạn hợp đồng.',
        date: '3 tiếng trước',
      ), PloNotification(
        fromBy: 'Admin',
        content: 'Còn 1 tuần nữa là bãi xe của bạn sẽ đóng do hết hợp đồng. Chúng tôi sẽ liên hệ một cách sớm nhất để gia hạn hợp đồng.',
        date: '3 tiếng trước',
      ),

    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Thông báo',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: getNotifications().length,
          itemBuilder: (context, index) {
            final notifications = getNotifications()[index];
            return NotificationCard(notification: notifications);
          },
        ),
      ),
    );
  }
}

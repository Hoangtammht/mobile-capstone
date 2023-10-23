import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/PLONotification.dart';
import 'package:fe_capstone/ui/components/widgetPLO/NotificationCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  Future<List<PLONotification>>? listNotificationFuture;

  @override
  void initState() {
    super.initState();
    listNotificationFuture = _getListNotificationFuture();
  }

  Future<List<PLONotification>> _getListNotificationFuture() async {
      return ParkingAPI.getNotifications();
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
      body: FutureBuilder<List<PLONotification>>(
        future: listNotificationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final notification = snapshot.data![index];
                return NotificationCard(notification: notification);
              },
            );
          }
        },
      ),
    );
  }
}

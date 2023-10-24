import 'package:fe_capstone/apis/customer/NoticationAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/CustomerNotification.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/CustomerNotificationCard.dart';
import 'package:flutter/material.dart';

class CustomerNotificationScreen extends StatefulWidget {
  const CustomerNotificationScreen({Key? key}) : super(key: key);

  @override
  State<CustomerNotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<CustomerNotificationScreen> {
  Future<List<CustomerNotification>>? customerNoti;


  @override
  void initState() {
    super.initState();
    customerNoti = _getListCustomerNotiFuture();
  }

  Future<List<CustomerNotification>> _getListCustomerNotiFuture() async {
    return NoticationAPI.getNotication();
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
      body: FutureBuilder<List<CustomerNotification>>(
        future: customerNoti, // Thay thế customerNoti bằng Future bạn muốn sử dụng
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('Không có thông báo'));
          } else {

            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final notification = snapshot.data![index];
                  return CustomerNotificationCard(notification: notification);
                },
              ),
            );
          }
        },
      ),
    );
  }
}

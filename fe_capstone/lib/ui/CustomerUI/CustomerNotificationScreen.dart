import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/CustomerNotification.dart';
import 'package:fe_capstone/models/PloNotification.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/CustomerNotificationCard.dart';
import 'package:fe_capstone/ui/components/widgetPLO/NotificationCard.dart';
import 'package:flutter/material.dart';

class CustomerNotificationScreen extends StatefulWidget {
  const CustomerNotificationScreen({Key? key}) : super(key: key);

  @override
  State<CustomerNotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<CustomerNotificationScreen> {

  List<CustomerNotification> getNotifications() {
    return [
      CustomerNotification(
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU',
        fromBy: 'Bãi xe Hoàng Hoa Thám',
        content: 'Bạn mới checkin ở bãi xe.',
        date: '3 tiếng trước',
      ),
      CustomerNotification(
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU',
        fromBy: 'Bãi xe của tôi',
        content: 'Bạn đã quá hạn gửi xe. Bạn phải trả phí thêm 3000VNĐ cho chủ bãi xe',
        date: '3 tiếng trước',
      ), CustomerNotification(
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU',
        fromBy: 'Bãi xe mệt mỏi',
        content: 'Còn 10 phút nữa là phải checkout. Nếu không bạn phải trả thêm phí.',
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
            return CustomerNotificationCard(notification: notifications,);
          },
        ),
      ),
    );
  }
}

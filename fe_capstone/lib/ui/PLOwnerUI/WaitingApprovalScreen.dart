import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class WaitingApprovalScreen extends StatelessWidget {
  const WaitingApprovalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Parco', style: TextStyle(
          fontSize:  26*ffem,
          fontWeight:  FontWeight.w500,
          height:  1.175*ffem/fem,
          fontStyle:  FontStyle.italic,
          color:  Color(0xff000000),
        ),),
        actions: [
          Image.asset('assets/images/chat.png')
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/waitingConfirm.png'),
            Padding(
              padding: EdgeInsets.only(top: 15 * fem),
              child: Text('Đơn đăng ký của bạn\nđang chờ kiểm duyệt', style: TextStyle(
                fontSize: 18 * fem,
                fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15 * fem),
              child: Text('Chúng tôi sẽ sớm liên hệ lại từ 12 - 24h', style: TextStyle(
                  fontSize: 18 * fem,
                  fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }
}

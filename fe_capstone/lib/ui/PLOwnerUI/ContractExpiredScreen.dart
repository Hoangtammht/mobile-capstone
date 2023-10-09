import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class ContractExpiredScreen extends StatelessWidget {
  const ContractExpiredScreen({Key? key}) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 55 * fem),
              child: Image.asset('assets/images/expired.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15 * fem),
              child: Text('Hợp đồng bãi đỗ xe của bạn \nđã hết hiệu lực',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20 * fem,
                  fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15 * fem),
              child: Text('Liên hệ số điện thoại \n0912345678 \nđể được hỗ trợ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20 * fem,
                  fontWeight: FontWeight.w400
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

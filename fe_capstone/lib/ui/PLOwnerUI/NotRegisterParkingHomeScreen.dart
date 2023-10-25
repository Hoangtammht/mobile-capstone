import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloChatScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/RegisterParking.dart';
import 'package:flutter/material.dart';


class NotRegisterParkingHomeScreen extends StatelessWidget {
  const NotRegisterParkingHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Parco', style: TextStyle(
          fontSize:  35*ffem,
          fontWeight:  FontWeight.w500,
          height:  1.175*ffem/fem,
          fontStyle:  FontStyle.italic,
          color:  Color(0xff000000),
        ),),
        actions: [
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PloChatScreen()));
              },
              child: Image.asset('assets/images/chat.png'))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/oops.png'),
            Padding(
              padding: EdgeInsets.only(top: 20 * fem, bottom: 15 * fem),
              child: Text(
                'Bạn chưa đăng ký bãi đỗ xe',
                style:  TextStyle (
                  fontSize:  22*ffem,
                  fontWeight:  FontWeight.w600,
                  color:  Color(0xff000000),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterParking()));
              },
              child: Container(
                padding: EdgeInsets.all(8 * fem),
                margin: EdgeInsets.fromLTRB(
                    40 * fem, 0 * fem, 40 * fem, 0 * fem),
                height: 50 * fem,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(9 * fem),
                ),
                child: Center(
                  child: Text(
                    'Đăng kí bãi đỗ',
                    style: TextStyle(
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
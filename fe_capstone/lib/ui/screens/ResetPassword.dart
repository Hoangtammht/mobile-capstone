import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/CustomerUI/HomeScreen.dart';
import 'package:fe_capstone/ui/components/FooterComponent.dart';
import 'package:fe_capstone/ui/components/HeaderComponent.dart';
import 'package:fe_capstone/ui/screens/NewPasswordScreen.dart';
import 'package:fe_capstone/ui/screens/OTPScreen.dart';
import 'package:fe_capstone/ui/screens/RegisterScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            HeaderComponent(),
            Positioned(
              left: 10 * fem,
              right: 10 * fem,
              top: 189 * fem,
              child: Container(
                margin: EdgeInsets.only(top: 20 * fem),
                padding: EdgeInsets.fromLTRB(
                    16 * fem, 53 * fem, 16 * fem, 45 * fem),
                width: 362 * fem,
                height: 350 * fem,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(26 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1e000000),
                      offset: Offset(0 * fem, 0 * fem),
                      blurRadius: 25 * fem,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          16 * fem, 0 * fem, 3 * fem, 25.5 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 8 * fem, 0 * fem),
                            width: 30 * fem,
                            height: 30 * fem,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_rounded),
                              onPressed: () {
                                Navigator.pop(context); // Quay lại màn hình trước đó
                              },
                            ),
                          ),
                          Text(
                            'Quên mật khẩu ?',
                            style: TextStyle(
                              fontSize: 30 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2175 * ffem / fem,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          7 * fem, 0 * fem, 0 * fem, 16.5 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 297 * fem,
                      ),
                      child: Text(
                        'Vui lòng nhập tài khoản bạn muốn lấy lại mật khẩu',
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 0, 15 * fem), // Thêm khoảng cách bottom 15*fem
                      padding: EdgeInsets.fromLTRB(20.5 * fem, 0, 20.5 * fem,
                          0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w200,
                          height: 1.175 * ffem / fem,
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder
                              .none, // Loại bỏ viền của TextFormField
                          hintText: 'Số điện thoại', // Gợi ý cho người dùng
                          hintStyle: TextStyle(
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.175 * ffem / fem,
                            color: Color(0xffa3a3a3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 42 * fem,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(9 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x82000000),
                            offset: Offset(0 * fem, 4 * fem),
                            blurRadius: 10 * fem,
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(type: 2,)));
                        },
                        child: Center(
                          child: Text(
                            'TIẾP TỤC',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.175 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 750 * fem,
              child: Container(
                width: mq.width,
                child: Align(
                  alignment: Alignment.center,
                  child: FooterComponent(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

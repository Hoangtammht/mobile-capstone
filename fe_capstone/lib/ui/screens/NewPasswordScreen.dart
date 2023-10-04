import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/components/FooterComponent.dart';
import 'package:fe_capstone/ui/components/HeaderComponent.dart';
import 'package:fe_capstone/ui/screens/LoginScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          const HeaderComponent(),
          Positioned(
            left: 10 * fem,
            right: 10 * fem,
            top: 189 * fem,
            child: Container(
              margin: EdgeInsets.only(top: 20 * fem),
              padding:
                  EdgeInsets.fromLTRB(16 * fem, 53 * fem, 16 * fem, 45 * fem),
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
                        0 * fem, 0 * fem, 0 * fem, 30 * fem),
                    child: Text(
                      'Nhập mật khẩu mới',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.175 * ffem / fem,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 20 * fem),
                    padding: EdgeInsets.fromLTRB(20.5 * fem, 0, 20.5 * fem, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(30 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            obscureText:
                                isPasswordVisible ? false : true, // Ẩn mật khẩu
                            style: TextStyle(
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.175 * ffem / fem,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Mật khẩu mới',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0xffa3a3a3),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility // Hiển thị khi mật khẩu ẩn
                                  : Icons
                                      .visibility_off, // Hiển thị khi mật khẩu hiển thị
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible =
                                    !isPasswordVisible; // Đảo ngược trạng thái
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 35 * fem),
                    padding: EdgeInsets.fromLTRB(20.5 * fem, 0, 20.5 * fem, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(30 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            obscureText: isConfirmPasswordVisible
                                ? false
                                : true, // Ẩn mật khẩu
                            style: TextStyle(
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.175 * ffem / fem,
                              color: Color(0xff000000),
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Xác nhận mật khẩu',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0xffa3a3a3),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              isConfirmPasswordVisible
                                  ? Icons.visibility // Hiển thị khi mật khẩu ẩn
                                  : Icons
                                      .visibility_off, // Hiển thị khi mật khẩu hiển thị
                            ),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible; // Đảo ngược trạng thái
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      elevation: 10 * fem,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 42 * fem,
                      child: Center(
                        child: Text(
                          'XÁC NHẬN',
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
                  )
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
          ),
        ],
      ),
    ));
  }
}

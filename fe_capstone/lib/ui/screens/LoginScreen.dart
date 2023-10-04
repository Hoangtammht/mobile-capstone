import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/CustomerUI/BottomTabNavCustomer.dart';
import 'package:fe_capstone/ui/CustomerUI/HomeScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/BottomTabNavPlo.dart';
import 'package:fe_capstone/ui/components/FooterComponent.dart';
import 'package:fe_capstone/ui/components/HeaderComponent.dart';
import 'package:fe_capstone/ui/screens/RegisterScreen.dart';
import 'package:fe_capstone/ui/screens/ResetPassword.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  List<String> list = <String>['Khách hàng', 'Chủ bãi xe'];
  late String dropdownValue = list.first;

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
              top: 193 * fem,
              child: Container(
                margin: EdgeInsets.only(top: 20 * fem),
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 55 * fem, 16 * fem, 29 * fem),
                width: 362 * fem,
                height: 520 * fem,
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
                          0 * fem, 0 * fem, 1 * fem, 36 * fem),
                      child: Text(
                        'ĐĂNG NHẬP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 150 * fem, bottom: 20 * fem),
                      child: DropdownMenu<String>(
                        initialSelection: list.first,
                        onSelected: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries:
                            list.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 0, 15 * fem), // Thêm khoảng cách bottom 15*fem
                      padding: EdgeInsets.fromLTRB(20.5 * fem, 0, 20.5 * fem,
                          0), // Thay đổi padding để loại bỏ khoảng cách ở trên và dưới
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff000000),
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
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 18 * fem),
                      padding:
                          EdgeInsets.fromLTRB(20.5 * fem, 0, 20.5 * fem, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              obscureText: isPasswordVisible
                                  ? false
                                  : true, // Ẩn mật khẩu
                              style: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Mật khẩu',
                                hintStyle: TextStyle(
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: const Color(0xffa3a3a3),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons
                                        .visibility // Hiển thị khi mật khẩu ẩn
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ResetPasswordScreen(), // Thay thế ResetPasswordScreen bằng tên thực tế của màn hình ResetPassword của bạn
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            189 * fem, 0 * fem, 0 * fem, 23 * fem),
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.175 * ffem / fem,
                            color: Theme.of(context).primaryColor,
                            // decoration: TextDecoration.underline, // Thêm gạch chân
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 64 * fem),
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
                      child: TextButton(
                        onPressed: () {
                          if(dropdownValue == 'Chủ bãi xe'){
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomTabNavPlo(),
                              ),
                            );
                          }else{
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomTabNavCustomer(),
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Text(
                            'ĐĂNG NHẬP',
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
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.175 * ffem / fem,
                            color: Theme.of(context).primaryColor,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Bạn chưa có tài khoản?  ',
                            ),
                            TextSpan(
                              text: 'Đăng ký',
                              style: TextStyle(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: const Color(0xff5767f5),
                                decoration:
                                    TextDecoration.underline, // Thêm gạch chân
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()),
                                  );
                                },
                            ),
                          ],
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

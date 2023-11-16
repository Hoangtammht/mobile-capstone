import 'package:fe_capstone/apis/Auth.dart';
import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/CustomerUI/BottomTabNavCustomer.dart';
import 'package:fe_capstone/ui/PLOwnerUI/BottomTabNavPlo.dart';
import 'package:fe_capstone/ui/components/FooterComponent.dart';
import 'package:fe_capstone/ui/components/HeaderComponent.dart';
import 'package:fe_capstone/ui/helper/dialogs.dart';
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
  String dropdownValue = 'CU';
  bool isLoading = false;

  void toggleUserRole() {
    setState(() {
      dropdownValue = dropdownValue == 'CU' ? 'PL' : 'CU';
    });
  }

  @override
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String getFullUserName() {
    String username = _userNameController.text;
    return dropdownValue + username;
  }

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
                width: mq.width,
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
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 15 * fem),
                      padding:
                          EdgeInsets.fromLTRB(20.5 * fem, 0, 20.5 * fem, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: toggleUserRole,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 14 * fem, 0),
                              child: Text(
                                dropdownValue == 'CU' ? 'C' : 'P',
                                style: TextStyle(
                                  fontSize: 25 * ffem,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffa3a3a3),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, 0, 11.5 * fem, 0.99 * fem),
                            width: 2 * fem,
                            height: 48.01 * fem,
                            decoration: BoxDecoration(color: Color(0xff6ec2f7)),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _userNameController,
                              style: TextStyle(
                                fontSize: 25 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Số điện thoại',
                                hintStyle: TextStyle(
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffa3a3a3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 18 * fem),
                      padding:
                          EdgeInsets.fromLTRB(20.5 * fem, 0, 20.5 * fem, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: isPasswordVisible ? false : true,
                              style: TextStyle(
                                fontSize: 25 * ffem,
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
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
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
                            builder: (context) => ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            189 * fem, 0 * fem, 0 * fem, 23 * fem),
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            fontSize: 25 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.175 * ffem / fem,
                            color: Theme.of(context).primaryColor,
                            // decoration: TextDecoration.underline,
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
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2.0,
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                String username = getFullUserName();
                                String password = _passwordController.text;
                                if (username.isNotEmpty &&
                                    password.isNotEmpty) {
                                  AuthAPIs.loginUser(username, password)
                                      .then((_) async {
                                    String? userID =
                                        await UserPreferences.getUserID();
                                    UserPreferences.setLoggedIn(true);
                                    UserPreferences.setUsername(username);
                                    UserPreferences.setPassword(password);
                                    if (username.startsWith('P')) {
                                      // if (await (await FirebaseAPI.userExists(
                                      //         userID!))
                                      //     .isEmpty) {
                                      //   await FirebaseAPI.createUser()
                                      //       .then((value) {
                                      //     Navigator.pushReplacement(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             BottomTabNavPlo(),
                                      //       ),
                                      //     );
                                      //   });
                                      // } else {
                                      //   Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           BottomTabNavPlo(),
                                      //     ),
                                      //   );
                                      // }
                                      await FirebaseAPI.createUser()
                                          .then((value) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BottomTabNavPlo(),
                                          ),
                                        );
                                      });
                                    } else if (username.startsWith('C')) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomTabNavCustomer(),
                                        ),
                                      );
                                    }
                                  }).catchError((error) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'Tài khoản hoặc mật khẩu không đúng. Vui lòng đăng nhập lại.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18 * fem),
                                      ),
                                      behavior: SnackBarBehavior.fixed,
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    Future.delayed(Duration(milliseconds: 1500),
                                        () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    });
                                  }).whenComplete(() {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                } else {
                                  setState(() {
                                    isLoading =
                                        false; // Ẩn CircularProgressIndicator khi xảy ra lỗi
                                  });
                                  final snackBar = SnackBar(
                                    content: Text(
                                      "Tài khoản hoặc mật khẩu không được để trống.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18 * fem),
                                    ),
                                    behavior: SnackBarBehavior.fixed,
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  Future.delayed(Duration(milliseconds: 1500),
                                      () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  });
                                }
                              },
                              child: Center(
                                child: Text(
                                  'ĐĂNG NHẬP',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25 * ffem,
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
                            fontSize: 20 * ffem,
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
                                fontSize: 22 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: const Color(0xff5767f5),
                                decoration: TextDecoration.underline,
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

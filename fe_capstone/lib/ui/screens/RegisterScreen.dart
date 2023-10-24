import 'package:fe_capstone/apis/Auth.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/components/FooterComponent.dart';
import 'package:fe_capstone/ui/components/HeaderComponent.dart';
import 'package:fe_capstone/ui/screens/LoginScreen.dart';
import 'package:fe_capstone/ui/screens/OTPScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isOwner = false;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();


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
                padding: EdgeInsets.fromLTRB(
                    20 * fem, 47 * fem, 20 * fem, 24 * fem),
                width: 362 * fem,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(26 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1e000000),
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
                          0 * fem, 0 * fem, 0 * fem, 25 * fem),
                      child: Text(
                        'ĐĂNG KÝ',
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
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 18 * fem),
                      padding: EdgeInsets.fromLTRB(
                          20.5 * fem, 0, 20.5 * fem, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: TextFormField(
                        controller: _fullNameController,
                        style: TextStyle(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Họ và tên',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xffa3a3a3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 18 * fem),
                      padding: EdgeInsets.fromLTRB(
                          20.5 * fem, 0, 20.5 * fem, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30 * fem),
                      ),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        style: TextStyle(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Số điện thoại',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xffa3a3a3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 18 * fem),
                      padding: EdgeInsets.fromLTRB(
                          20.5 * fem, 0, 20.5 * fem, 0),
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
                              controller: _passwordController,
                              obscureText: isPasswordVisible
                                  ? false
                                  : true,
                              style: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Mật khẩu',
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
                                    ? Icons
                                    .visibility
                                    : Icons
                                    .visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible =
                                  !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 5 * fem),
                      padding: EdgeInsets.fromLTRB(
                          20.5 * fem, 0, 20.5 * fem, 0),
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
                              controller: _confirmPasswordController,
                              obscureText: isConfirmPasswordVisible
                                  ? false
                                  : true, 
                              style: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
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
                                    ? Icons
                                    .visibility
                                    : Icons
                                    .visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildOwnerCheckbox(),
                    ElevatedButton(
                      onPressed: () async {
                        try{
                          String phoneNumber = _phoneNumberController.text;
                          String fullName = _fullNameController.text;
                          String password = _passwordController.text;
                          String role = isOwner ? "PLO" : "CUSTOMER";
                          print(phoneNumber);
                          print(role);
                          await AuthAPIs.registerUser(phoneNumber, role);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPScreen(type: 1, phoneNumber: phoneNumber, role: role, fullName: fullName, password: password,),
                            ),
                          );
                        }catch(e){
                          print(e);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9 * fem),
                        ),
                        elevation: 10 * fem,
                      ),
                      child: Container(
                        width: 322 * fem,
                        height: 42 * fem,
                        child: Center(
                          child: Text(
                            'ĐĂNG KÝ',
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
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 35 * fem, 3 * fem, 0 * fem),
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
                              TextSpan(
                                text: 'Bạn đã có tài khoản?  ',
                              ),
                              TextSpan(
                                text: 'Đăng Nhập',
                                style: TextStyle(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Color(0xff5767f5),
                                  decoration: TextDecoration
                                      .underline, // Thêm gạch chân
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen()),
                                    );
                                  },
                              ),
                            ],
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

  Widget buildOwnerCheckbox() {
    return CheckboxListTile(
      title: Text(
        "Bạn là chủ bãi xe",
        style: TextStyle(
          fontSize: 15 * ffem,
          fontWeight: FontWeight.w600,
          height: 1.175 * ffem / fem,
          color: Colors.grey,
        ),
      ),
      value: isOwner,
      onChanged: (newValue) {
        setState(() {
          isOwner = newValue ?? false;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, // Đặt checkbox bên trái văn bản
    );
  }
}

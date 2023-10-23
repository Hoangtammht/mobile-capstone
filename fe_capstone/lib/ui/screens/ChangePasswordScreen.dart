import 'package:fe_capstone/apis/Auth.dart';
import 'package:fe_capstone/apis/plo/AuthAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/screens/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isNewConfirmPasswordVisible = false;
  TextEditingController _OldPasswordController = TextEditingController();
  TextEditingController _NewPasswordController = TextEditingController();
  TextEditingController _ReNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'THAY ĐỔI MẬT KHẨU',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: 780,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(26 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 650,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0 * fem,
                      top: 0 * fem,
                      child: Container(
                        width: 390 * fem,
                        height: 120 * fem,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(23 * fem),
                            bottomLeft: Radius.circular(23 * fem),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10 * fem,
                      right: 10 * fem,
                      top: 40 * fem,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            16 * fem, 20 * fem, 16 * fem, 10 * fem),
                        width: 362 * fem,
                        height: 490 * fem,
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
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  2 * fem, 0 * fem, 0 * fem, 16 * fem),
                              child: Text(
                                'Mật khẩu cũ',
                                style: TextStyle(
                                  fontSize: 19 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  2 * fem, 0 * fem, 0 * fem, 20 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  8 * fem, 2 * fem, 2 * fem, 10 * fem),
                              width: 327 * fem,
                              decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(9 * fem),
                              ),
                              child: TextFormField(
                                controller: _OldPasswordController,
                                obscureText:
                                    isOldPasswordVisible ? false : true,
                                style: TextStyle(
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Theme.of(context).primaryColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nhập mật khẩu cũ',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color(0xffa3a3a3),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isOldPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isOldPasswordVisible =
                                            !isOldPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              child: Text(
                                'Mật khẩu mới',
                                style: TextStyle(
                                  fontSize: 19 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  2 * fem, 0 * fem, 0 * fem, 20 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  8 * fem, 2 * fem, 2 * fem, 10 * fem),
                              width: 327 * fem,
                              height: 51 * fem,
                              decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(9 * fem),
                              ),
                              child: TextFormField(
                                controller: _NewPasswordController,
                                obscureText: isNewPasswordVisible
                                    ? false
                                    : true, // Để ẩn mật khẩu nếu đây là ô mật khẩu
                                style: TextStyle(
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Theme.of(context).primaryColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nhập mật khẩu mới',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color(0xffa3a3a3),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isNewPasswordVisible
                                          ? Icons
                                              .visibility // Hiển thị khi mật khẩu ẩn
                                          : Icons
                                              .visibility_off, // Màu của icon
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isNewPasswordVisible =
                                            !isNewPasswordVisible;
                                      });
                                      // Xử lý khi nhấn vào biểu tượng ẩn/mở mật khẩu
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  2 * fem, 0 * fem, 0 * fem, 16 * fem),
                              child: Text(
                                'Nhập lại mật khẩu mới',
                                style: TextStyle(
                                  fontSize: 19 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  2 * fem, 0 * fem, 0 * fem, 20 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  8 * fem, 2 * fem, 2 * fem, 10 * fem),
                              width: 327 * fem,
                              height: 51 * fem,
                              decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(9 * fem),
                              ),
                              child: TextFormField(
                                controller: _ReNewPasswordController,
                                obscureText: isNewConfirmPasswordVisible
                                    ? false
                                    : true, // Để ẩn mật khẩu nếu đây là ô mật khẩu
                                style: TextStyle(
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Theme.of(context).primaryColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nhập lại mật khẩu mới',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color(0xffa3a3a3),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isNewConfirmPasswordVisible
                                          ? Icons
                                              .visibility // Hiển thị khi mật khẩu ẩn
                                          : Icons
                                              .visibility_off, // Màu của icon
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isNewConfirmPasswordVisible =
                                            !isNewConfirmPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                String oldPassword = _OldPasswordController.text;
                                String newPassword = _NewPasswordController.text;
                                String reNewPassword = _ReNewPasswordController.text;

                                if (newPassword != reNewPassword) {
                                  _showFailureDialog(context);
                                } else {
                                    await AuthAPIs.changePassword(oldPassword, newPassword, reNewPassword)
                                        .then((_) {
                                      _showSuccessfulDialog(context);
                                    }).catchError((error) {
                                      _showFailureDialog(context);
                                    });
                                }

                                _OldPasswordController.clear();
                                _NewPasswordController.clear();
                                _ReNewPasswordController.clear();

                              },
                              child: Container(
                                width: 322 * fem,
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
                                child: Center(
                                  child: Text(
                                    'Lưu mật khẩu',
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSuccessfulDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(10 * fem, 32 * fem, 10 * fem, 0),
              width: double.infinity,
              height: 300 * fem,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(23 * fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 12 * fem, 11 * fem),
                    width: 100 * fem,
                    height: 100 * fem,
                    child: Image.asset('assets/images/success.png'),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        2 * fem, 0 * fem, 0 * fem, 23 * fem),
                    child: Text(
                      'Chúc mừng bạn!',
                      style: TextStyle(
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.175 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 25 * fem),
                    child: Text(
                      'Hệ thống đã lưu thay đổi của bạn!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xff999999),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 60 * fem,
                      height: 42 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xff6ec2f7),
                        borderRadius: BorderRadius.circular(9 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x82000000),
                            offset: Offset(0 * fem, 4 * fem),
                            blurRadius: 10 * fem,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Center(
                          child: Text(
                            'Ok',
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showFailureDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(10 * fem, 32 * fem, 10 * fem, 0),
              width: double.infinity,
              height: 300 * fem,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(23 * fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 11 * fem),
                    width: 100 * fem,
                    height: 100 * fem,
                    child: Image.asset('assets/images/failure.png'),
                  ),
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 5 * fem),
                    child: Text(
                      'Hệ thống gặp trục trặc',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xff999999),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 15 * fem),
                    child: Text(
                      'Hãy thử lại lần sau',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xff999999),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 60 * fem,
                      height: 42 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xff6ec2f7),
                        borderRadius: BorderRadius.circular(9 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x82000000),
                            offset: Offset(0 * fem, 4 * fem),
                            blurRadius: 10 * fem,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Center(
                          child: Text(
                            'Ok',
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

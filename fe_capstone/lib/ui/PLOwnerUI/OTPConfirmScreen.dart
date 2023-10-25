import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPConfirmScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPConfirmScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPConfirmScreen> createState() => _OTPConfirmScreenState();
}

class _OTPConfirmScreenState extends State<OTPConfirmScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String otpCode = "";

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
          'CẬP NHẬT SỐ ĐIỆN THOẠI',
          style: TextStyle(
            fontSize: 30 * ffem,
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
                            16 * fem, 60 * fem, 16 * fem, 60 * fem),
                        width: 362 * fem,
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
                            OtpForm(
                              formKey: _formKey,
                              onSaved: (value) {
                              },
                              onCompleted: (otp) {
                                otpCode = otp;
                              },
                            ),
                            // Container(
                            //   margin: EdgeInsets.fromLTRB(
                            //       3 * fem, 0 * fem, 0 * fem, 27.5 * fem),
                            //   width: 332 * fem,
                            //   height: 1 * fem,
                            // ),
                            // Center(
                            //   child: Container(
                            //     margin: EdgeInsets.fromLTRB(
                            //         0 * fem, 0 * fem, 5 * fem, 17.5 * fem),
                            //     child: Text(
                            //       '0:10',
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //         fontSize: 16 * ffem,
                            //         fontWeight: FontWeight.w600,
                            //         height: 1.175 * ffem / fem,
                            //         color: Color(0xff999999),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  3 * fem, 0 * fem, 0 * fem, 29 * fem),
                              constraints: BoxConstraints(
                                maxWidth: 294 * fem,
                              ),
                              child: Text(
                                'Nhập mã OTP đã được gửi về số điện thoại ${widget.phoneNumber}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2175 * ffem / fem,
                                  color: Color(0xff999999),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 173 * fem, 18 * fem),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 22 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.175 * ffem / fem,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' ',
                                      ),
                                      TextSpan(
                                        text: 'Gửi lại mã OTP',
                                        style: TextStyle(
                                          fontSize: 22 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.175 * ffem / fem,
                                          color: Color(0xff5767f5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                  try {
                                    await ParkingAPI
                                        .checkOTPcodeTransferParking(
                                      otpCode,
                                      widget.phoneNumber,
                                    );
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PloProfileScreen()), (route) => false);
                                  } catch (e) {
                                    _showFailureDialog(context);
                                  }
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
                                    'Xác minh',
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
              padding:  EdgeInsets.fromLTRB(10*fem, 32*fem, 10*fem, 0),
              width:  double.infinity,
              height: 300 * fem,
              decoration:  BoxDecoration (
                color:  Color(0xffffffff),
                borderRadius:  BorderRadius.circular(23*fem),
              ),
              child:
              Column(
                crossAxisAlignment:  CrossAxisAlignment.center,
                children:  [
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 11*fem),
                    width:  100*fem,
                    height:  100*fem,
                    child:
                    Image.asset(
                        'assets/images/success.png'
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 23*fem),
                    child:
                    Text(
                      'Chúc mừng bạn!',
                      style:  TextStyle (
                        fontSize:  24*ffem,
                        fontWeight:  FontWeight.w600,
                        height:  1.175*ffem/fem,
                        color:  Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 25*fem),
                    child:
                    Text(
                      'Việc chuyển cập nhật số điện thoại đã thành công !',
                      textAlign:  TextAlign.center,
                      style:  TextStyle (
                        fontSize:  16*ffem,
                        fontWeight:  FontWeight.w400,
                        height:  1.2175*ffem/fem,
                        color:  Color(0xff999999),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PloProfileScreen()), (route) => false);
                    },
                    child: Container(
                      width:  60 * fem,
                      height:  42*fem,
                      decoration:  BoxDecoration (
                        color:  Color(0xff6ec2f7),
                        borderRadius:  BorderRadius.circular(9*fem),
                        boxShadow:  [
                          BoxShadow(
                            color:  Color(0x82000000),
                            offset:  Offset(0*fem, 4*fem),
                            blurRadius:  10*fem,
                          ),
                        ],
                      ),
                      child:
                      Center(
                        child:
                        Center(
                          child:
                          Text(
                            'Ok',
                            textAlign:  TextAlign.center,
                            style:  TextStyle (
                              fontSize:  16*ffem,
                              fontWeight:  FontWeight.w600,
                              height:  1.175*ffem/fem,
                              color:  Color(0xffffffff),
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
              padding:  EdgeInsets.fromLTRB(10*fem, 32*fem, 10*fem, 0),
              width:  double.infinity,
              height: 300 * fem,
              decoration:  BoxDecoration (
                color:  Color(0xffffffff),
                borderRadius:  BorderRadius.circular(23*fem),
              ),
              child:
              Column(
                crossAxisAlignment:  CrossAxisAlignment.center,
                children:  [
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0 * fem, 11*fem),
                    width:  100*fem,
                    height:  100*fem,
                    child:
                    Image.asset(
                        'assets/images/failure.png'
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 23*fem),
                    child:
                    Text(
                      'Thất bại',
                      style:  TextStyle (
                        fontSize:  24*ffem,
                        fontWeight:  FontWeight.w600,
                        height:  1.175*ffem/fem,
                        color:  Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 25*fem),
                    child:
                    Text(
                      'Việc cập nhật số điện thoại đã thất bại !',
                      textAlign:  TextAlign.center,
                      style:  TextStyle (
                        fontSize:  16*ffem,
                        fontWeight:  FontWeight.w400,
                        height:  1.2175*ffem/fem,
                        color:  Color(0xff999999),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width:  60 * fem,
                      height:  42*fem,
                      decoration:  BoxDecoration (
                        color:  Color(0xff6ec2f7),
                        borderRadius:  BorderRadius.circular(9*fem),
                        boxShadow:  [
                          BoxShadow(
                            color:  Color(0x82000000),
                            offset:  Offset(0*fem, 4*fem),
                            blurRadius:  10*fem,
                          ),
                        ],
                      ),
                      child:
                      Center(
                        child:
                        Center(
                          child:
                          Text(
                            'Ok',
                            textAlign:  TextAlign.center,
                            style:  TextStyle (
                              fontSize:  16*ffem,
                              fontWeight:  FontWeight.w600,
                              height:  1.175*ffem/fem,
                              color:  Color(0xffffffff),
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

class OtpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String) onSaved;
  final Function(String) onCompleted;
  const OtpForm({Key? key, required this.formKey, required this.onSaved, required this.onCompleted}) : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 64 * fem,
            width: 30 * fem,
            child: TextFormField(
              autofocus: true,
              onSaved: (pin1){},
              onChanged: (value){
                if (value.length == 1) {
                  setState(() {
                    otpCode += value;
                    if (otpCode.length < 4) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      widget.onCompleted(otpCode);
                    }
                  });
                }
              },
              keyboardType: TextInputType.text,
              maxLength: 1,
              decoration: InputDecoration(counterText: ""),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 64 * fem,
            width: 30 * fem,
            child: TextFormField(
              autofocus: true,
              onSaved: (pin2){},
              onChanged: (value){
                if (value.length == 1) {
                  setState(() {
                    otpCode += value;
                    if (otpCode.length < 4) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      widget.onCompleted(otpCode); // Gọi hàm callback khi chuỗi OTP đã đủ 4 ký tự
                    }
                  });
                }
              },
              keyboardType: TextInputType.text,
              maxLength: 1,
              decoration: InputDecoration(counterText: ""),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 64 * fem,
            width: 30 * fem,
            child: TextFormField(
              autofocus: true,
              onSaved: (pin3){},
              onChanged: (value){
                if (value.length == 1) {
                  setState(() {
                    otpCode += value;
                    if (otpCode.length < 4) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      widget.onCompleted(otpCode); // Gọi hàm callback khi chuỗi OTP đã đủ 4 ký tự
                    }
                  });
                }
              },
              keyboardType: TextInputType.text,
              maxLength: 1,
              decoration: InputDecoration(counterText: ""),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 64 * fem,
            width: 30 * fem,
            child: TextFormField(
              autofocus: true,
              onSaved: (pin4){},
              onChanged: (value){
                if (value.length == 1) {
                  setState(() {
                    otpCode += value;
                    if (otpCode.length < 4) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      widget.onCompleted(otpCode); // Gọi hàm callback khi chuỗi OTP đã đủ 4 ký tự
                    }
                  });
                }
              },
              keyboardType: TextInputType.text,
              maxLength: 1,
              decoration: InputDecoration(counterText: ""),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}


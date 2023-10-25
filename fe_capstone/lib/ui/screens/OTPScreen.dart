import 'package:fe_capstone/apis/Auth.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/components/FooterComponent.dart';
import 'package:fe_capstone/ui/components/HeaderComponent.dart';
import 'package:fe_capstone/ui/screens/LoginScreen.dart';
import 'package:fe_capstone/ui/screens/NewPasswordScreen.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  final int type;
  final String phoneNumber;
  final String role;
  final String? fullName;
  final String? password;
  const OTPScreen(
      {Key? key,
      required this.type,
      required this.phoneNumber,
      required this.role,
        this.fullName,
        this.password,
      })
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String otpCode = "";

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
              top: 193 * fem,
              child: Container(
                margin: EdgeInsets.only(top: 20 * fem),
                padding:
                    EdgeInsets.fromLTRB(16 * fem, 53 * fem, 11 * fem, 45 * fem),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          16 * fem, 0 * fem, 64 * fem, 25 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 1 * fem, 8 * fem, 0 * fem),
                                width: 30 * fem,
                                height: 30 * fem,
                                child: Icon(Icons.arrow_back_ios_new)),
                          ),
                          Text(
                            'Nhập mã OTP',
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
                    OtpForm(
                      formKey: _formKey,
                      onSaved: (value) {},
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
                              fontSize: 16 * ffem,
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
                    ElevatedButton(
                      onPressed: () async {
                        if (widget.type == 1) {
                          try{
                            await AuthAPIs.confirmRegisterOTP(widget.fullName!, otpCode, widget.password!, widget.phoneNumber, widget.role);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }catch(e){
                            print(e);
                          }
                        } else {
                          try {
                            await AuthAPIs.verifyOTP(
                                otpCode, widget.phoneNumber);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewPasswordScreen(phoneNumber: widget.phoneNumber, role: widget.role),
                              ),
                            );
                          } catch (e) {
                            print(e);
                          }
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
                            'XÁC MINH',
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
            )
          ],
        ),
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String) onSaved;
  final Function(String) onCompleted;
  const OtpForm(
      {Key? key,
      required this.formKey,
      required this.onSaved,
      required this.onCompleted})
      : super(key: key);

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
              onSaved: (pin1) {},
              onChanged: (value) {
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
              onSaved: (pin2) {},
              onChanged: (value) {
                if (value.length == 1) {
                  setState(() {
                    otpCode += value;
                    if (otpCode.length < 4) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      widget.onCompleted(
                          otpCode); // Gọi hàm callback khi chuỗi OTP đã đủ 4 ký tự
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
              onSaved: (pin3) {},
              onChanged: (value) {
                if (value.length == 1) {
                  setState(() {
                    otpCode += value;
                    if (otpCode.length < 4) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      widget.onCompleted(
                          otpCode); // Gọi hàm callback khi chuỗi OTP đã đủ 4 ký tự
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
              onSaved: (pin4) {},
              onChanged: (value) {
                if (value.length == 1) {
                  setState(() {
                    otpCode += value;
                    if (otpCode.length < 4) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      widget.onCompleted(
                          otpCode); // Gọi hàm callback khi chuỗi OTP đã đủ 4 ký tự
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

import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class OTPConfirmScreen extends StatefulWidget {
  const OTPConfirmScreen({Key? key}) : super(key: key);

  @override
  State<OTPConfirmScreen> createState() => _OTPConfirmScreenState();
}

class _OTPConfirmScreenState extends State<OTPConfirmScreen> {
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
          'CHUYỂN DỮ LIỆU BÃI XE',
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
                            OtpForm(),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  3 * fem, 0 * fem, 0 * fem, 27.5 * fem),
                              width: 332 * fem,
                              height: 1 * fem,
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5 * fem, 17.5 * fem),
                                child: Text(
                                  '0:10',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xff999999),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  3 * fem, 0 * fem, 0 * fem, 29 * fem),
                              constraints: BoxConstraints(
                                maxWidth: 294 * fem,
                              ),
                              child: Text(
                                'Nhập mã OTP đã được gửi về số điện thoại 09030239230',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16 * ffem,
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
                                          fontSize: 16 * ffem,
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
                              onTap: () {
                                _showFailureDialog(context);
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
                      'Việc chuyển dữ liệu đã thành công !',
                      textAlign:  TextAlign.center,
                      style:  TextStyle (
                        fontSize:  16*ffem,
                        fontWeight:  FontWeight.w400,
                        height:  1.2175*ffem/fem,
                        color:  Color(0xff999999),
                      ),
                    ),
                  ),
                  Container(
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
                      'Việc chuyển đổi dữ liệu đã thất bại !',
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

class OtpForm extends StatelessWidget {
  const OtpForm({Key? key}) : super(key: key);

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
                if(value.length == 1){
                  FocusScope.of(context).nextFocus();
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
                if(value.length == 1){
                  FocusScope.of(context).nextFocus();
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
                if(value.length == 1){
                  FocusScope.of(context).nextFocus();
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
                if(value.length == 1){
                  FocusScope.of(context).nextFocus();
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


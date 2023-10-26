import 'dart:io';

import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/PaymentResponse.dart';
import 'package:fe_capstone/models/RequestResgisterParking.dart';
import 'package:fe_capstone/ui/PLOwnerUI/BottomTabNavPlo.dart';
import 'package:fe_capstone/ui/PLOwnerUI/RegisterFeeWebView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationFeeScreen extends StatefulWidget {
  final RequestRegisterParking requestRegisterParking;
  const RegistrationFeeScreen({Key? key, required this.requestRegisterParking}) : super(key: key);

  @override
  State<RegistrationFeeScreen> createState() => _RegistrationFeeScreenState();
}

class _RegistrationFeeScreenState extends State<RegistrationFeeScreen> {
  late RequestRegisterParking request;

  @override
  void initState() {
    super.initState();
  }

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
          'Phí đăng ký',
          style: TextStyle(
            fontSize: 35 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30 * fem),
                child: Center(
                  child: Text(
                    '350.000 VNĐ',
                    style: TextStyle(
                        fontSize: 35 * fem, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                    try {
                      PaymentResponse paymentResponse = await ParkingAPI.makePayment();
                      String newUUID = paymentResponse.uuid;
                      String paymentUrl = paymentResponse.paymentUrl;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RechargeWebViewScreen(paymentUrl),
                        ),
                      );
                      setState(() {
                        request = RequestRegisterParking(
                            address: widget.requestRegisterParking.address,
                            description: widget.requestRegisterParking.description,
                            images: widget.requestRegisterParking.images,
                            length: widget.requestRegisterParking.length,
                            parkingName: widget.requestRegisterParking.parkingName,
                            slot: widget.requestRegisterParking.slot,
                            uuid: newUUID,
                            width: widget.requestRegisterParking.width
                        );
                      });
                    } catch (e) {
                      print('Error: $e');
                    }
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      10 * fem, 0 * fem, 10 * fem, 10 * fem),
                  height: 40 * fem,
                  width: 150 * fem,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(9 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Đóng phí đăng kí',
                      style: TextStyle(
                        fontSize: 22 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.175 * ffem / fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40 * fem, bottom: 20 * fem),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: 'Điều khoản hợp đồng: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22 * fem)),
                          TextSpan(
                              text: 'Trong hợp đồng',
                              style: TextStyle(
                                fontSize: 22 * fem,
                              ))
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30 * fem),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: 'Lưu ý: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22 * fem)),
                          TextSpan(
                              text: 'Phí đăng kí sẽ được trừ vào tiền hợp đồng',
                              style: TextStyle(
                                fontSize: 22 * fem,
                              ))
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                    try {
                      print(request.toJson());
                      await ParkingAPI.registerParking(request);
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: BottomTabNavPlo(),
                        withNavBar: false,
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    } catch (e) {
                      print('Error: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Đăng kí thông tin bãi xe thất bại'),
                        ),
                      );
                    }
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      10 * fem, 0 * fem, 10 * fem, 10 * fem),
                  height: 50 * fem,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(9 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Gửi phiếu đăng kí',
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
    );
  }
}

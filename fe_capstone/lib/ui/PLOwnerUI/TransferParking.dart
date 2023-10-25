import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/PLOwnerUI/OTPConfirmScreen.dart';
import 'package:fe_capstone/ui/screens/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferParking extends StatefulWidget {
  const TransferParking({Key? key}) : super(key: key);

  @override
  State<TransferParking> createState() => _TransferParkingState();
}

class _TransferParkingState extends State<TransferParking> {
  TextEditingController _phoneNumberController = TextEditingController();

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
                        width: mq.width,
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
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 25 * fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Nhập số điện thoại mà bạn',
                                    style: TextStyle(
                                      fontSize: 25 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2175 * ffem / fem,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'muốn chuyển dữ liệu',
                                    style: TextStyle(
                                      fontSize: 25 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2175 * ffem / fem,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 45 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  20.5 * fem, 0, 20.5 * fem, 0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(30 * fem),
                              ),
                              child: TextFormField(
                                controller: _phoneNumberController,
                                style: TextStyle(
                                  fontSize: 22 * ffem,
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
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xffa3a3a3),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                String phoneNumber =
                                    _phoneNumberController.text;
                                try {
                                  await ParkingAPI.checkPLOTransfer(
                                      phoneNumber);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OTPConfirmScreen(
                                              phoneNumber: phoneNumber,
                                            )),
                                  );
                                } catch (e) {
                                  print('Error: $e');
                                }
                              },
                              child: Container(
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
}

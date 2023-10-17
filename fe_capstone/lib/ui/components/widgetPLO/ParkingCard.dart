import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ListVehicleInParking.dart';
import 'package:fe_capstone/ui/PLOwnerUI/ParkingScreen.dart';
import 'package:fe_capstone/ui/components/widgetPLO/ParkingDetailCard.dart';
import 'package:fe_capstone/ui/helper/my_date_until.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingCard extends StatefulWidget {
  final List<String> type;
  final ListVehicleInParking vehicleData;
  const ParkingCard({Key? key, required this.type, required this.vehicleData}) : super(key: key);

  @override
  State<ParkingCard> createState() => _ParkingCardState();
}

class _ParkingCardState extends State<ParkingCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ParkingDetailCard(type: widget.type,)));
      },
      child: Container(
        margin:  EdgeInsets.fromLTRB(5*fem, 3*fem, 5*fem, 5*fem),
        padding: EdgeInsets.fromLTRB(3*fem, 3*fem, 3*fem, 5*fem),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 3 * fem, top: 3 * fem, bottom: 3 * fem),
                  child: Text(
                    widget.vehicleData.licensePlate,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Spacer(),
                if(widget.type.contains('Later'))
                Padding(
                  padding: EdgeInsets.only(left: 3 * fem, top: 3 * fem, bottom: 3 * fem),
                  child: Text(
                    'Trễ giờ',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 3 * fem, top: 3 * fem, bottom: 3 * fem),
              child: Text(
                widget.vehicleData.fullName,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12 * fem,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3 * fem, top: 3 * fem, bottom: 3 * fem),
              child: Row(
                children: [
                  Container(
                    width: 83 * fem,
                    height: 23 * fem,
                    decoration: BoxDecoration(
                      color: Color(0xffe4f6e6),
                      borderRadius: BorderRadius.circular(3 * fem),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.vehicleData.methodName,
                        style: TextStyle(
                          fontSize: 11 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff2b7031),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  if (widget.type.contains("Going"))
                    InkWell(
                      onTap: (){
                        _showUpdateVehicleEntryDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(3 * fem, 3 * fem, 3 * fem, 3 * fem),
                        width: 160 * fem,
                        height: 40 * fem,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(9 * fem),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor,
                              offset: Offset(0 * fem, 4 * fem),
                              blurRadius: 10 * fem,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Cập nhập đã tới',
                            style: TextStyle(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.bold,
                              height: 1.175 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    )
                    else if (widget.type.contains("Present"))
                    InkWell(
                      onTap: (){
                        print('Chuẩn bị rời bãi');
                        _showUpdateVehicleExitDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(3 * fem, 3 * fem, 3 * fem, 3 * fem),
                        width: 160 * fem,
                        height: 40 * fem,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(9 * fem),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor,
                              offset: Offset(0 * fem, 4 * fem),
                              blurRadius: 10 * fem,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Cập nhập rời bãi',
                            style: TextStyle(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.bold,
                              height: 1.175 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    )
                    else
                    Text(
                      '${MyDateUtil.formatDateTime(widget.vehicleData.startTime)} - ${MyDateUtil.formatDateTime(widget.vehicleData.endTime)}',
                      style: TextStyle(
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.175 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3 * fem, top: 3 * fem, bottom: 3 * fem),
              child: Divider(
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showUpdateVehicleEntryDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                                text: 'Cập nhập trạng thái',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                )
                            ),
                            TextSpan(
                                text: ' vào bãi',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                )
                            )
                          ]
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      widget.vehicleData.licensePlate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center, // Căn giữa dọc
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5767f5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 1,
                          height: 48,
                          color: Color(0xffb3abab),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                      },
                      child: Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 1,
                              color: Color(0xffb3abab),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Xác nhận',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffff3737),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showUpdateVehicleExitDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                                text: 'Cập nhập trạng thái',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                )
                            ),
                            TextSpan(
                                text: ' rời bãi',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                )
                            )
                          ]
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      widget.vehicleData.licensePlate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (widget.type.contains('Later'))
                Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: '*Lưu ý: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        TextSpan(
                            text: 'Biển số xe này đã rời bãi trễ giờ. Phải đóng phí phạt',
                            style: TextStyle(
                              fontSize: 18,
                            )
                        )
                      ]
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5767f5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 1,
                          height: 48,
                          color: Color(0xffb3abab),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              String? accessToken = prefs.getString('access_token');
                              if (accessToken != null) {
                                int reservationID = int.parse(widget.vehicleData.reservationID);
                                try {
                                  await ParkingAPI.checkoutReservation(accessToken, reservationID);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ParkingScreen()));
                                } catch (e) {
                                }
                              } else {
                              }
                            },
                            child: Text(
                              'Xác nhận',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffff3737),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

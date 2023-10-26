import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ParkingStatusInformation.dart';
import 'package:flutter/material.dart';

class WaitingParkingCard extends StatelessWidget {
  final TotalComing listVehicleComing;
  WaitingParkingCard({Key? key, required this.listVehicleComing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 3 * fem, top: 3 * fem, bottom: 3 * fem),
          child: Text(
            listVehicleComing.licensePlate,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20 * fem,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 3 * fem, top: 3 * fem, bottom: 3 * fem),
          child: Text(
            listVehicleComing.fullName,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18 * fem,
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
                    listVehicleComing.methodName,
                    style: TextStyle(
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.2175 * ffem / fem,
                      color: Color(0xff2b7031),
                    ),
                  ),
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
    );
  }
}


import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ParkingInformationModel.dart';
import 'package:flutter/material.dart';


class ListParkingCard extends StatelessWidget {
  final ParkingHomeScreen  fakeData ;
  const ListParkingCard(this.fakeData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slot = fakeData.slot;
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12 * fem, horizontal: 15 * fem),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fakeData.parkingName, style: TextStyle(
                fontSize: 20 * fem,
                fontWeight: FontWeight.bold
            ),),
            Padding(
              padding: EdgeInsets.only(top: 5 * fem, bottom: 10 * fem),
              child: Text(fakeData.address, style: TextStyle(
                color: Colors.grey,
                fontSize: 18 * fem,
              ),),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10 * fem),
                  width:  83*fem,
                  height:  23*fem,
                  decoration:  BoxDecoration (
                    color:  Color(0xffe4f6e6),
                    borderRadius:  BorderRadius.circular(3*fem),
                  ),
                  child: Center(
                    child: Text(
                      'Còn $slot chỗ',
                      style:  TextStyle (
                        fontSize:  15*ffem,
                        fontWeight:  FontWeight.w400,
                        height:  1.2175*ffem/fem,
                        color:  Color(0xff2b7031),
                      ),
                    ),
                  ),
                ),
                Container(
                  width:  60*fem,
                  height:  23*fem,
                  decoration:  BoxDecoration (
                    color:  Colors.grey[300],
                    borderRadius:  BorderRadius.circular(3*fem),
                  ),
                  child: Center(
                    child: Text(
                      '5 m',
                      style:  TextStyle (
                        fontSize:  15*ffem,
                        fontWeight:  FontWeight.w400,
                        height:  1.2175*ffem/fem,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10 * fem),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class WaitingParkingCard extends StatelessWidget {
  const WaitingParkingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 3 * fem, top: 3 * fem, bottom: 3 * fem),
          child: Text(
            '61A-999999',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16 * fem,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 3 * fem, top: 3 * fem, bottom: 3 * fem),
          child: Text(
            'Mai Hoàng Tâm',
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
                    'Ban ngày',
                    style: TextStyle(
                      fontSize: 11 * ffem,
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

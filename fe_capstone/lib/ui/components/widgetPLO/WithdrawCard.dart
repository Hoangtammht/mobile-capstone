import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/helper/my_date_until.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WithdrawCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final double amount;

  const WithdrawCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.time,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 15 * fem),
      width: double.infinity,
      height: 32 * fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(9 * fem, 3 * fem, 0 * fem, 5 * fem),
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: double.infinity,
                  child: Row(
                    children: [
                    Container(
                    width: 32 * fem,
                    height: 32 * fem,
                    child: Icon(icon)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 2 * fem),
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 13 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              MyDateUtil.formatCheckInAndCheckOutDate(time),
                              style: TextStyle(
                                fontSize: 10 * ffem,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff9e9e9e),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin:
            EdgeInsets.fromLTRB(0 * fem, 2 * fem, 0 * fem, 0 * fem),
            child: Text(
              '${NumberFormat("#,##0", "en_US").format(amount)} đ',
              style: TextStyle(
                fontSize: 13 * ffem,
                fontWeight: FontWeight.w500,
                height: 1.2175 * ffem / fem,
                color: Color(0xffcc5252),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

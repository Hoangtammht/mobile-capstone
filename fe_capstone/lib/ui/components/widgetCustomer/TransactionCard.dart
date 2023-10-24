import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helper/my_date_until.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 15 * fem),
      width: double.infinity,
      height: 45 * fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0 * fem, 3 * fem, 0 * fem, 5 * fem),
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: double.infinity,
                  child: Row(
                    children: [
                      Container(
                          width: 40 * fem,
                          height: 60 * fem,
                          child: Icon(Icons.account_balance_wallet_outlined)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 5 * fem),
                            child: Text(
                              transaction.title,
                              style: TextStyle(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Text(
                            MyDateUtil.formatCheckInAndCheckOutDate(transaction.date),
                            style: TextStyle(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff9e9e9e),
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
              '+ ${NumberFormat("#,##0", "en_US").format(transaction.amount)} đ',
              style: TextStyle(
                fontSize: 18 * ffem,
                fontWeight: FontWeight.bold,
                height: 1.2175 * ffem / fem,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

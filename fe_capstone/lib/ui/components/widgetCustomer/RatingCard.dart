import 'package:fe_capstone/ui/components/widgetCustomer/RatingStars.dart';
import 'package:fe_capstone/ui/helper/my_date_until.dart';
import 'package:flutter/material.dart';
import 'package:fe_capstone/main.dart';
import 'package:intl/intl.dart';

class RatingCard extends StatelessWidget {
  final String fromBy;
  final int star;
  final String content;
  final String? feedbackDate;
  const RatingCard({Key? key, required this.fromBy, required this.star, required this.content, this.feedbackDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15 * fem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10 * fem),
            child: Row(
              children: [
                Text(fromBy, style: TextStyle(
                  fontSize: 20 * fem,
                  fontWeight: FontWeight.bold
                ),),
                RatingStars(
                    rating: star
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5 * fem),
            child: Text(content, style: TextStyle(
              fontSize: 18 * fem,
              color: Colors.grey
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5 * fem),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                MyDateUtil.formatCheckInAndCheckOutDate(feedbackDate!),
                style: TextStyle(
                  fontSize: 15 * fem,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

import 'package:fe_capstone/ui/components/widgetCustomer/RatingStars.dart';
import 'package:flutter/material.dart';
import 'package:fe_capstone/main.dart';

class RatingCard extends StatelessWidget {
  final String fromBy;
  final int star;
  final String content;
  const RatingCard({Key? key, required this.fromBy, required this.star, required this.content}) : super(key: key);

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
          Divider(
            thickness: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

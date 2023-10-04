import 'package:fe_capstone/ui/components/widgetCustomer/RatingStars.dart';
import 'package:flutter/material.dart';
import 'package:fe_capstone/main.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({Key? key}) : super(key: key);

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
                Text('Mai Hoàng Tâm', style: TextStyle(
                  fontSize: 18 * fem,
                  fontWeight: FontWeight.bold
                ),),
                RatingStars(
                    rating: 4
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5 * fem),
            child: Text('Đang stress tìm chỗ mà đặt được chỗ ưng ghê', style: TextStyle(
              fontSize: 15 * fem,
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

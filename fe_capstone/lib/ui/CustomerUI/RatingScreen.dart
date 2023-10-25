import 'package:fe_capstone/ui/components/widgetCustomer/RatingCard.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/RatingStars.dart';
import 'package:flutter/material.dart';
import 'package:fe_capstone/main.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({Key? key}) : super(key: key);

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
          'ĐÁNG GIÁ',
          style: TextStyle(
            fontSize: 30 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10 * fem),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 4,
            itemBuilder: (context, index){
          return RatingCard(fromBy: "Mai Hoàng Tâm",star: 5,content: "Thoái mái, sạch sẽ",);
        }),
      ),
    );
  }
}

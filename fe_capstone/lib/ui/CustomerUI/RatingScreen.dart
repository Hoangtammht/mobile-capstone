import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/models/RatingModel.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/RatingCard.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/RatingStars.dart';
import 'package:flutter/material.dart';
import 'package:fe_capstone/main.dart';

class RatingScreen extends StatefulWidget {
  final String ploID;

  RatingScreen({required this.ploID});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  Future<List<CustomerRating>>? ratingList;

  @override
  void initState() {
    super.initState();
    ratingList = _getRatingListFuture();
  }

  Future<List<CustomerRating>> _getRatingListFuture() async {
    return ParkingAPI.getRatingParkingLot(widget.ploID);
  }

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
          'ĐÁNH GIÁ',
          style: TextStyle(
            fontSize: 30 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: FutureBuilder<List<CustomerRating>>(
        future: ratingList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<CustomerRating> ratings = snapshot.data!;

            return Container(
              margin: EdgeInsets.only(top: 10 * fem),
              child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.vertical,
                itemCount: ratings.length,
                itemBuilder: (context, index) {
                  return RatingCard(
                    fromBy: ratings[index].customerName,
                    star: ratings[index].rating,
                    content: ratings[index].content,
                    feedbackDate: ratings[index].feedbackDate,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

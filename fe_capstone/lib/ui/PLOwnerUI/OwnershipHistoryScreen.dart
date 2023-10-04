import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/components/widgetPLO/OnwershipParkingCard.dart';
import 'package:flutter/material.dart';

class OwnershipHistoryScreen extends StatefulWidget {
  const OwnershipHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OwnershipHistoryScreen> createState() => _OwnershipHistoryScreenState();
}

class _OwnershipHistoryScreenState extends State<OwnershipHistoryScreen> {

  List<String> status = [
    '1' , '2'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
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
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'LỊCH SỬ BÃI XE TỪNG\n',
                style: TextStyle(
                  fontSize: 26 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.175 * ffem / fem,
                  color: Color(0xffffffff),
                ),
              ),
              TextSpan(
                text: 'SỞ HỮU',
                style: TextStyle(
                  fontSize: 26 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.175 * ffem / fem,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20 * fem, left: 5 * fem, right: 5 * fem, bottom: 20 * fem),
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: status.length,
            itemBuilder: (context, index){
          return OwnershipHistoryCard(status: status[index],);
        }),
      ),
    );
  }
}

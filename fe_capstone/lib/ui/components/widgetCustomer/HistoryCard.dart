import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/History.dart';
import 'package:fe_capstone/ui/CustomerUI/ReBooking.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final History history;
  const HistoryCard({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReBooking(title: history.title,)));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${history.title}',
                style: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 8 * fem),
              Text(
                '${history.address}',
                style: TextStyle(
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff969696),
                ),
              ),
              SizedBox(height: 4 * fem),
              Container(
                width:  80*fem,
                height:  20*fem,
                decoration:  BoxDecoration (
                  color:  Color(0xffe4f6e6),
                  borderRadius:  BorderRadius.circular(10*fem),
                ),
                child:
                Center(
                  child:
                  Text(
                    history.status,
                    style:  TextStyle (
                      fontSize:  11*ffem,
                      fontWeight:  FontWeight.w400,
                      height:  1.2175*ffem/fem,
                      color:  Color(0xff2b7031),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8 * fem),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${history.checkIn}',
                    style: TextStyle(
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Color(0xff969696),
                    ),
                  ),
                  Text(
                    '${history.checkOut}',
                    style: TextStyle(
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Color(0xff969696),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

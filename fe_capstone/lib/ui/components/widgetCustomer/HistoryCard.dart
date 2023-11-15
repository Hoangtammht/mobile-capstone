import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/History.dart';
import 'package:fe_capstone/ui/CustomerUI/ReBooking.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final History history;
  final VoidCallback? onNavigateToHomeScreen;
  const HistoryCard({Key? key, required this.history, this.onNavigateToHomeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Rebooking(reservationId: history.reservationID, onNavigateToHomeScreen: onNavigateToHomeScreen)));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${history.parkingName}',
                style: TextStyle(
                  fontSize: 20 * ffem,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 8 * fem),
              Text(
                '${history.address}',
                style: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff969696),
                ),
              ),
              SizedBox(height: 4 * fem),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                        history.methodName,
                        style:  TextStyle (
                          fontSize:  14*ffem,
                          fontWeight:  FontWeight.w400,
                          height:  1.2175*ffem/fem,
                          color:  Color(0xff2b7031),
                        ),
                      ),
                    ),
                  ),
                  if(history.statusID == 4)
                  Container(
                    width:  70* fem,
                    height: 20 * fem,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100 * fem),
                    ),
                    child: Center(
                      child: Text(
                         'Hoàn thành',
                        style: TextStyle(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if(history.statusID == 5)
                    Container(
                      width:  70* fem,
                      height: 20 * fem,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Hủy đặt',
                          style: TextStyle(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
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

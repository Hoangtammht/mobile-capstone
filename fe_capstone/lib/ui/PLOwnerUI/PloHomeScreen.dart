import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloChatScreen.dart';
import 'package:fe_capstone/ui/components/widgetPLO/WaitingParkingCard.dart';
import 'package:flutter/material.dart';

enum ParkingStatus { closed, available }

class PloHomeScreen extends StatefulWidget {
  const PloHomeScreen({Key? key}) : super(key: key);

  @override
  State<PloHomeScreen> createState() => _PloHomeScreenState();
}

class _PloHomeScreenState extends State<PloHomeScreen> {
  ParkingStatus _selectedStatus = ParkingStatus.closed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Parco',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w500,
            height: 1.175 * ffem / fem,
            fontStyle: FontStyle.italic,
            color: Color(0xff000000),
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PloChatScreen()));
              },
              child: Image.asset('assets/images/chat.png'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15 * fem, vertical: 5 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20 * fem, bottom: 30 * fem),
                  height: 263 * fem,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(26 * fem),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1e000000),
                        offset: Offset(0 * fem, 0 * fem),
                        blurRadius: 40 * fem,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15 * fem, top: 35 * fem, bottom: 10 * fem),
                        child: Text(
                          'Doanh thu hôm nay',
                          style: TextStyle(
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.2175 * ffem / fem,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15 * fem,
                            right: 15 * fem,
                            top: 5 * fem,
                            bottom: 35 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 1 * fem, 5 * fem, 0 * fem),
                                  child: Text(
                                    'VND',
                                    style: TextStyle(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2175 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Text(
                                  '12.000',
                                  style: TextStyle(
                                    fontSize: 35 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175 * ffem / fem,
                                    color: Color(0xff2b7031),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/images/chart.png',
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15 * fem, top: 15 * fem, bottom: 10 * fem),
                        child: Text(
                          'Xe đang trong bãi',
                          style: TextStyle(
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.2175 * ffem / fem,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15 * fem,
                            right: 15 * fem,
                            top: 5 * fem,
                            bottom: 35 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '3',
                              style: TextStyle(
                                fontSize: 35 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.2175 * ffem / fem,
                              ),
                            ),
                            Image.asset(
                              'assets/images/statistics.png',
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(left: 5 * fem,top: 5 * fem, bottom: 20 * fem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Trạng thái', style: TextStyle(
                      fontSize: 18 * fem,
                      fontWeight: FontWeight.w400
                    ),),
                    DropdownButton<ParkingStatus>(
                      value: _selectedStatus,
                      onChanged: (ParkingStatus? newValue) {
                        setState(() {
                          _showChangeStatusDialog(context);
                          // _showSettingParkingDialog(context);
                          _selectedStatus = newValue!;
                        });
                      },
                      items: <ParkingStatus>[
                        ParkingStatus.closed,
                        ParkingStatus.available,
                      ].map<DropdownMenuItem<ParkingStatus>>((ParkingStatus value) {
                        String text;
                        Color? backgroundColor;
                        Color textColor;
                        switch (value) {
                          case ParkingStatus.closed:
                            text = 'Đóng';
                            backgroundColor = Colors.red;
                            textColor = Colors.white;
                            break;
                          case ParkingStatus.available:
                            text = 'Còn chỗ';
                            backgroundColor = Colors.green;
                            textColor = Colors.white;
                            break;
                        }
                        return DropdownMenuItem<ParkingStatus>(
                          value: value,
                          child: Container(
                            color: backgroundColor,
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              text,
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5 * fem, bottom: 20 * fem),
                child: Text('Xe sắp tới', style: TextStyle(
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.w400
                ),),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 5 * fem),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder:(context, index){
                  return WaitingParkingCard();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showChangeStatusDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30 * fem, top: 20 * fem),
                    child: Column(children: [
                      Text('Thay đổi trạng thái sang',
                          style: TextStyle(
                              fontSize: 18 * fem, fontWeight: FontWeight.bold)),
                      if (_selectedStatus == ParkingStatus.available)
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10 * fem, bottom: 5 * fem),
                          child: Text('còn chỗ',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18 * fem,
                                  fontWeight: FontWeight.bold)),
                        )
                      else if (_selectedStatus == ParkingStatus.closed)
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10 * fem, bottom: 5 * fem),
                          child: Text('đóng',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18 * fem,
                                  fontWeight: FontWeight.bold)),
                        ),
                    ]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Color(0xffb3abab), // Đường thẳng ngang
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5767f5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 1,
                          height: 48,
                          color: Color(0xffb3abab),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Xác nhận',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffff3737),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSettingParkingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      "Cài đặt phương thức và giá tiền để \nchuyển đổi trạng thái hoạt động",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center, // Căn giữa dọc
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Color(0xffb3abab), // Đường thẳng ngang
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5767f5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 1,
                          height: 48,
                          color: Color(0xffb3abab), // Đường thẳng dọc
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Color(0xffb3abab), // Đường thẳng ngang
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Đóng hộp thoại
                            },
                            child: Text(
                              'Xác nhận',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffff3737),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}

import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/PLOwnerUI/ParkingInformation.dart';
import 'package:fe_capstone/ui/PLOwnerUI/ParkingPresentScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/SettingParking.dart';
import 'package:fe_capstone/ui/components/widgetPLO/ConfirmDeleteDialog.dart';
import 'package:flutter/material.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool isConfirmed = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Bãi xe',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: const Color(0xffffffff),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'settings',
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingParkingScreen()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4 * fem),
                          child: Text('Cài đặt'),
                        )
                      ],
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmDeleteDialog();
                          }
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4 * fem),
                          child: Text(
                            'Xóa',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'information',
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ParkingInformation()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4 * fem),
                          child: Text('Thông tin'),
                        )
                      ],
                    ),
                  ),
                ),
              ];
            },
            onSelected: (String value) {
              // Xử lý khi một mục được chọn
              if (value == 'settings') {
                // Xử lý khi chọn "Cài đặt"
              } else if (value == 'delete') {
                // Xử lý khi chọn "Xóa"
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Hiện tại (2)',
            ),
            Tab(
              text: 'Đang tới (1)',
            ),
            Tab(
              text: 'Quá giờ (1)',
            ),
            Tab(
              text: 'Lịch sử',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          ParkingPresent(type: ["Present", "Later"]),
          ParkingPresent(type: ["Going"]),
          ParkingPresent(type: ["Later"]),
          ParkingPresent(type: ["Normal"]),
        ],
      ),
    );
  }

  Future<void> _showConfirmDeleteParkingDialog(BuildContext context) async {
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15 * fem, vertical: 10 * fem),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Xóa bãi đỗ xe này khỏi tài khoản của bạn',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18 * fem),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8 * fem),
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: '*Lưu ý: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14 * fem)),
                      TextSpan(
                          text:
                              'Doanh thu vẫn chưa được rút ra khỏi tài khoản. Bạn sẽ mất nếu tiếp tục xóa.',
                          style: TextStyle(
                            fontSize: 14 * fem,
                          ))
                    ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Checkbox(
                        value: isConfirmed,
                        activeColor:
                            isConfirmed ? Colors.yellowAccent : Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        onChanged: (value) {
                          setState(() {
                            isConfirmed = !isConfirmed;
                          });
                        },
                      ),
                    ),
                    // Nút lựa chọn xác nhận
                    Text('Click vô ô bên nếu bạn muốn tiếp tục xóa')
                  ],
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

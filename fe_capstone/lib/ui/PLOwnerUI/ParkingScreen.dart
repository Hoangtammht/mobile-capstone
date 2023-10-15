import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ListVehicleInParking.dart';
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
  late List<ListVehicleInParking> list1 = [];
  late List<ListVehicleInParking> list2 = [];
  late List<ListVehicleInParking> list3 = [];
  late List<ListVehicleInParking> list4 = [];

  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJQTDA5MzQzMjg4MTMiLCJyb2xlIjoiUExPIiwiaXNzIjoiaHR0cHM6Ly9lcGFya2luZy5henVyZXdlYnNpdGVzLm5ldC91c2VyL2xvZ2luVXNlciJ9.Etq-tq7gqaBvuWZTowodVXG9xjAX044FySmFp80mvic";


  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
    fetchData();
    print('Init state called');
  }

  void fetchData() async {
    try {
      list1 = await ParkingAPI.fetchListVehicleInParking(token, 1);
      list2 = await ParkingAPI.fetchListVehicleInParking(token, 2);
      list3 = await ParkingAPI.fetchListVehicleInParking(token, 3);
      list4 = await ParkingAPI.fetchListVehicleInParking(token, 4);
      setState(() {

      });
    } catch (e) {
      // Xử lý lỗi ở đây
    }
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
              if (value == 'settings') {
              } else if (value == 'delete') {
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
          ParkingPresent(type: ["Present"], vehicleList: list1),
          ParkingPresent(type: ["Going"], vehicleList: list2),
          ParkingPresent(type: ["Later"], vehicleList: list3),
          ParkingPresent(type: ["Normal"], vehicleList: list4),
        ],
      ),
    );
  }

}

import 'dart:async';
import 'dart:convert';

import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/base_constant.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ListVehicleInParking.dart';
import 'package:fe_capstone/ui/PLOwnerUI/CheckReservationByLicensePlate.dart';
import 'package:fe_capstone/ui/PLOwnerUI/ParkingInformation.dart';
import 'package:fe_capstone/ui/PLOwnerUI/ParkingPresentScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/SettingParking.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  late int list1Length = 0;
  late int list2Length = 0;
  WebSocketChannel ploChannel = IOWebSocketChannel.connect(BaseConstants.WEBSOCKET_PRIVATE_PLO_URL);


  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
    fetchData();
    initializeState();
  }

  void initializeState() async {
    String? ploID = await UserPreferences.getUsername();
    final message = {
      "ploID": ploID,
      "content": "Connected"
    };
    final messageJson = jsonEncode(message);
    ploChannel.sink.add(messageJson);
    ploChannel.stream.listen((message) {
      handleMessage(message);
    });

    bool isLoggedIn = UserPreferences.isLoggedIn();
    if (isLoggedIn) {
      const duration = Duration(seconds: 30);
      Timer.periodic(duration, (Timer t) {
        final message = {
          "ploID": ploID,
          "content": "KeepAlive"
        };
        final messageJson = jsonEncode(message);
        if (ploChannel.sink != null) {
          ploChannel.sink.add(messageJson);
          print('KeepAlive message sent successfully.');
        } else {
          print('Channel sink is closed. KeepAlive message not sent.');
          t.cancel();
        }
      });
    }
  }

  void handleMessage(dynamic message) {
    print(message.toString());
    if (message.toString().contains("GetParking")) {
      fetchData();
    }
  }

  void updateUI() {
    fetchData();
  }

  void fetchData() async {
    try {
      list1 = await ParkingAPI.fetchListVehicleInParking(2);
      list2 = await ParkingAPI.fetchListVehicleInParking(1);
      list3 = await ParkingAPI.fetchListVehicleInParking(4);
      setState(() {
        list1Length = list1.length;
        list2Length = list2.length;
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
            fontSize: 30 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: const Color(0xffffffff),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CheckOutByLicensePlate(updateUI: updateUI)));
            },
            icon: Icon(Icons.qr_code_scanner),
          ),
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
                          child: Text('Cài đặt', style: TextStyle(
                              fontSize: 20 * fem
                          ),),
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
                          child: Text('Thông tin', style: TextStyle(
                            fontSize: 20 * fem
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
              ];
            },
            onSelected: (String value) {
              if (value == 'settings') {
              } else if (value == 'delete') {}
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Hiện tại ($list1Length)',
            ),
            Tab(
              text: 'Đang tới ($list2Length)',
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
          ParkingPresent(
            type: ["Present"],
            vehicleList: list1,
            updateUI: updateUI,
          ),
          ParkingPresent(
              type: ["Going"], vehicleList: list2, updateUI: updateUI),
          ParkingPresent(
              type: ["History"], vehicleList: list3, updateUI: updateUI),
        ],
      ),
    );
  }
}



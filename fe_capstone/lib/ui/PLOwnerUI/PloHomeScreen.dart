import 'dart:async';
import 'dart:convert';

import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ListVehicleInParking.dart';
import 'package:fe_capstone/models/ParkingStatusInformation.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloChatScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/SettingParking.dart';
import 'package:fe_capstone/ui/components/widgetPLO/WaitingParkingCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum ParkingStatus { approved, open, closed }

class PloHomeScreen extends StatefulWidget {
  const PloHomeScreen({Key? key}) : super(key: key);

  @override
  State<PloHomeScreen> createState() => _PloHomeScreenState();
}

class _PloHomeScreenState extends State<PloHomeScreen> {

  late Future<ParkingStatusInformation> statusParkingFuture;
  int parkingStatusID = 0;
  late ParkingStatus currentParkingStatus;
  WebSocketChannel channel = IOWebSocketChannel.connect('wss://eparkingcapstone.azurewebsites.net/privatePLO');

  List<TotalComing> totalComing = [];

  late Future<double> walletPLO;
  late List<ListVehicleInParking> list1 = [];
  late int list1Length = 0;

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  void initializeState() async {
    print('loading');
    statusParkingFuture = _getParkingInformationFuture();
    statusParkingFuture.then((data) {
      parkingStatusID = data?.parkingStatusID ?? 0;
      totalComing = data?.totalComing ?? [];
      currentParkingStatus = _getParkingStatusFromID(parkingStatusID);
    });
    walletPLO = _getWalletFuture();
    fetchVehicleInParking();
    String? ploID = await UserPreferences.getUsername();
    final message = {
      "ploID": ploID,
      "content": "Connected"
    };
    final messageJson = jsonEncode(message);
    channel.sink.add(messageJson);
    channel.stream.listen((message) {
      handleMessage(message);
    });
    bool isLoggedIn = UserPreferences.isLoggedIn();
    if (isLoggedIn) {
      const duration = Duration(minutes: 3);
      Timer.periodic(duration, (Timer t) {
        final message = {
          "ploID": ploID,
          "content": "KeepAlive"
        };
        final messageJson = jsonEncode(message);
        if (channel.sink != null) {
          channel.sink.add(messageJson);
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
          statusParkingFuture = _getParkingInformationFuture();
          walletPLO = _getWalletFuture();
          _reloadParkingInformation();
    }
  }

  Future<ParkingStatusInformation> _getParkingInformationFuture() async {
      return ParkingAPI.getParkingStatusID();
  }

  Future<void> _reloadParkingInformation() async {
    try {
      final data = await _getParkingInformationFuture();
      setState(() {
        parkingStatusID = data?.parkingStatusID ?? 0;
        totalComing = data?.totalComing ?? [];
        currentParkingStatus = _getParkingStatusFromID(parkingStatusID);
      });
    } catch (e) {
      print('Error reloading parking information: $e');
    }
  }

  void fetchVehicleInParking() async {
    try {
        list1 = await ParkingAPI.fetchListVehicleInParking(2);
      setState(() {
        list1Length = list1.length;
      });
    } catch (e) {}
  }

  Future<double> _getWalletFuture() async {
      return ParkingAPI.getBalance();
  }

  ParkingStatus _getParkingStatusFromID(int statusID) {
    switch (statusID) {
      case 3:
        return ParkingStatus.approved;
      case 4:
        return ParkingStatus.open;
      case 5:
        return ParkingStatus.closed;
      default:
        return ParkingStatus.closed;
    }
  }

  int _getParkingStatusID(ParkingStatus status) {
    switch (status) {
      case ParkingStatus.approved:
        return 3;
      case ParkingStatus.open:
        return 4;
      case ParkingStatus.closed:
        return 5;
      default:
        return 5;
    }
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Parco',
          style: TextStyle(
            fontSize: 35 * ffem,
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
      body: Padding(
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
                        'Ví tiền',
                        style: TextStyle(
                          fontSize: 22 * ffem,
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
                                    fontSize: 18 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2175 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              FutureBuilder<double>(
                                future: walletPLO,
                                builder: (BuildContext context,
                                    AsyncSnapshot<double> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    final formatter =
                                        NumberFormat("#,##0", "en_US");
                                    final formattedValue =
                                        formatter.format(snapshot.data);
                                    return Text(
                                      formattedValue,
                                      style: TextStyle(
                                        fontSize: 38 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2175 * ffem / fem,
                                        color: Color(0xff2b7031),
                                      ),
                                    );
                                  }
                                },
                              )
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
                          fontSize: 22 * ffem,
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
                            list1Length.toString(),
                            style: TextStyle(
                              fontSize: 38 * ffem,
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
              padding: EdgeInsets.only(
                  left: 5 * fem, top: 5 * fem, bottom: 20 * fem),
              child: FutureBuilder<ParkingStatusInformation?>(
                future: statusParkingFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trạng thái',
                          style: TextStyle(
                              fontSize: 22 * fem, fontWeight: FontWeight.w400),
                        ),
                        DropdownButton<ParkingStatus>(
                          value: currentParkingStatus,
                          onChanged: (ParkingStatus? newValue) {
                            setState(() {
                              _showChangeStatusDialog(context, newValue!);
                            });
                          },
                          items: () {
                            if (currentParkingStatus ==
                                ParkingStatus.approved) {
                              return <DropdownMenuItem<ParkingStatus>>[
                                DropdownMenuItem<ParkingStatus>(
                                  value: ParkingStatus.approved,
                                  child: Container(
                                    color: currentParkingStatus ==
                                            ParkingStatus.approved
                                        ? Colors.yellow
                                        : Colors.white,
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Cài đặt',
                                      style: TextStyle(
                                        color: currentParkingStatus ==
                                                ParkingStatus.approved
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ];
                            } else if (currentParkingStatus ==
                                ParkingStatus.open) {
                              return <DropdownMenuItem<ParkingStatus>>[
                                DropdownMenuItem<ParkingStatus>(
                                  value: ParkingStatus.closed,
                                  child: Container(
                                    color: currentParkingStatus ==
                                            ParkingStatus.closed
                                        ? Colors.red
                                        : Colors.white,
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Đóng',
                                      style: TextStyle(
                                        color: currentParkingStatus ==
                                                ParkingStatus.closed
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<ParkingStatus>(
                                  value: ParkingStatus.open,
                                  child: Container(
                                    color: currentParkingStatus ==
                                            ParkingStatus.open
                                        ? Colors.green
                                        : Colors.white,
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Còn chỗ',
                                      style: TextStyle(
                                        color: currentParkingStatus ==
                                                ParkingStatus.open
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ];
                            } else if (currentParkingStatus ==
                                ParkingStatus.closed){
                              return <DropdownMenuItem<ParkingStatus>>[
                                DropdownMenuItem<ParkingStatus>(
                                  value: ParkingStatus.open,
                                  child: Container(
                                    color: currentParkingStatus ==
                                            ParkingStatus.open
                                        ? Colors.green
                                        : Colors.white,
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Còn chỗ',
                                      style: TextStyle(
                                        color: currentParkingStatus ==
                                                ParkingStatus.open
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<ParkingStatus>(
                                  value: ParkingStatus.closed,
                                  child: Container(
                                    color: currentParkingStatus ==
                                            ParkingStatus.closed
                                        ? Colors.red
                                        : Colors.white,
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Đóng',
                                      style: TextStyle(
                                        color: currentParkingStatus ==
                                                ParkingStatus.closed
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ];
                            }
                          }(),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5 * fem, bottom: 20 * fem),
              child: Text(
                'Xe sắp tới',
                style:
                    TextStyle(fontSize: 20 * fem, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              height: 220 * fem,
              child: Padding(
                padding: EdgeInsets.only(left: 5 * fem),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: totalComing.length,
                  itemBuilder: (context, index) {
                    return WaitingParkingCard(
                      listVehicleComing: totalComing[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showChangeStatusDialog(BuildContext context, ParkingStatus newValue) async {
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
                              fontSize: 22 * fem, fontWeight: FontWeight.bold)),
                      if (currentParkingStatus == ParkingStatus.closed)
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10 * fem, bottom: 5 * fem),
                          child: Text('còn chỗ',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 22 * fem,
                                  fontWeight: FontWeight.bold)),
                        )
                      else if (currentParkingStatus == ParkingStatus.open)
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10 * fem, bottom: 5 * fem),
                          child: Text('đóng',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22 * fem,
                                  fontWeight: FontWeight.bold)),
                        )
                      else if (currentParkingStatus == ParkingStatus.approved)
                          Padding(
                            padding:
                            EdgeInsets.only(top: 10 * fem, bottom: 5 * fem),
                            child: Text('cài đặt bãi xe',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 22 * fem,
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
                            color: Color(0xffb3abab),
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
                            onPressed: () async {
                              if (currentParkingStatus == ParkingStatus.approved) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SettingParkingScreen()),
                                );
                                  setState(() {
                                    currentParkingStatus = ParkingStatus.open;
                                  });
                                  await ParkingAPI.updateParkingStatusID(4);
                                  await _reloadParkingInformation();
                              } else {
                                setState(() {
                                  currentParkingStatus = newValue!;
                                });
                                await ParkingAPI.updateParkingStatusID(_getParkingStatusID(newValue!));
                                Navigator.pop(context);
                                await _reloadParkingInformation();
                              }
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
                            color: Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
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

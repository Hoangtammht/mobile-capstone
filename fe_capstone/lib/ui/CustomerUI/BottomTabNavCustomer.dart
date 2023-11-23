import 'dart:async';
import 'dart:convert';

import 'package:fe_capstone/apis/customer/HomeAPI.dart';
import 'package:fe_capstone/apis/customer/ReservationAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/base_constant.dart';
import 'package:fe_capstone/models/CustomerHome.dart';
import 'package:fe_capstone/ui/CustomerUI/CustomerNotificationScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/HistoryScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/HomeScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/ProfileScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/WalletScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BottomTabNavCustomer extends StatefulWidget {
  @override
  State<BottomTabNavCustomer> createState() => _BottomTabNavCustomerState();
}

class _BottomTabNavCustomerState extends State<BottomTabNavCustomer> {
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);
  Future<CustomerHome>? customerHome;

  Future<CustomerHome> _getHomeStatus() {
    return HomeAPI.getHomeStatus();
  }

  @override
  void initState() {
    super.initState();
  }

  void changeTabWalletController(){
    _controller.jumpToTab(2);
  }

  void changeTabHomeScreenController(){
    _controller.jumpToTab(0);
  }

  String convertToDesiredFormat(String input) {
    try {
      DateFormat inputFormat = DateFormat('HH:mm:ss - dd/MM/yyyy');
      DateTime dateTime = inputFormat.parse(input);
      DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      return outputFormat.format(dateTime);
    } catch (e) {
      print('Error converting date format: $e');
      return '';
    }
  }

  Duration parseDuration(String durationString) {
    List<String> timeParts = durationString.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    int seconds = int.parse(timeParts[2]);
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  void callApiBeforeCancelBooking(Duration beforeCancelBooking,
      DateTime afterCancelBooking, int reservationID, String ploID) async {
    try {
      bool isUpdateSuccessful =
      await Future.delayed(beforeCancelBooking, () async {
        return await ReservationAPI.updateReservationToCancel(reservationID);
      });
      print('Update trước 15 phút là $isUpdateSuccessful');
      if (isUpdateSuccessful) {
        print('Hiện tại trước 15 phút');
      } else {
        callApiAtCancelBookingTime(
            afterCancelBooking.difference(DateTime.now()), reservationID, ploID);
      }
    } catch (e) {
      print('Error calling API: $e');
    }
  }

  Future<void> callApiAtCancelBookingTime(
      Duration duration, int reservationID, String ploID) async {
    try {
      await Future.delayed(duration, () async {
        bool isUpdateSuccessful =
        await ReservationAPI.updateReservationToCancel(reservationID);
        print('Update sau 15 phút là $isUpdateSuccessful');
        setState(() {
          customerHome = _getHomeStatus();
        });
        WebSocketChannel ploChannel =
        IOWebSocketChannel.connect(BaseConstants.WEBSOCKET_PRIVATE_PLO_URL);
        final message = {
          "ploID": ploID,
          "content": "GetParking"
        };
        final messageJson = jsonEncode(message);
        ploChannel.sink.add(messageJson);
      });
    } catch (e) {
      print('Error calling API: $e');
    }
  }

  void callApiBeforeUpdateStatusLater(
      Duration beforeUpdate, DateTime afterUpdate, int reservationID, String ploID) async {
    try {
      bool isUpdateSuccessful = await Future.delayed(beforeUpdate, () async {
        return await ReservationAPI.updateReservationToLater(reservationID);
      });
      print('Status của reservation trước khi trễ là $isUpdateSuccessful');
      if (isUpdateSuccessful) {
        print('Status hiện tại trước 15 phút');
      } else {
        callApiAfterStatusLater(
            afterUpdate.difference(DateTime.now()), reservationID, ploID);
      }
    } catch (e) {
      print('Error calling API: $e');
    }
  }

  Future<void> callApiAfterStatusLater(
      Duration duration, int reservationID, String ploID) async {
    try {
      await Future.delayed(duration, () async {
        bool isUpdateSuccessful =
        await ReservationAPI.updateReservationToLater(reservationID);
        print('Status của reservation sau 15 phút là $isUpdateSuccessful');
        setState(() {
          customerHome = _getHomeStatus();
        });
        WebSocketChannel ploChannel =
        IOWebSocketChannel.connect(BaseConstants.WEBSOCKET_PRIVATE_PLO_URL);
        final ploMessage = {
          "ploID": ploID.toString(),
          "content": "GetParking"
        };
        final messageJsonPLO = jsonEncode(ploMessage);
        ploChannel.sink.add(messageJsonPLO);
      });
    } catch (e) {
      print('Error calling API: $e');
    }
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(onNavigateToWallet: changeTabWalletController),
      HistoryScreen(onNavigateToHomeScreen: changeTabHomeScreenController),
      WalletScreen(),
      ProfileScreen(),
      CustomerNotificationScreen(),
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Trang chủ',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        title: 'Lịch sử',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_balance_wallet),
        title: 'Ví tiền',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: 'Cài đặt',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications_none),
        title: 'Thông báo',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CustomerHome>(
      future: customerHome,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            navBarStyle: NavBarStyle.style3,
            onItemSelected: (int) {
              if (_controller.index == 0) {
                setState(() {
                  customerHome = _getHomeStatus();
                  customerHome!.then((data) {
                    if (data.reservationID != 0) {
                        if (data.statusID == 1) {
                          String startTime = convertToDesiredFormat(data.startTime);
                          String cancelBookingTime = data.cancelBookingTime;
                          DateTime startDateTime = DateTime.parse(startTime);
                          Duration cancelBookingDuration = parseDuration(cancelBookingTime);
                          DateTime beforeCancelBookingTime = startDateTime
                              .add(cancelBookingDuration)
                              .subtract(Duration(minutes: 1));
                          DateTime cancelBookingDateTime = startDateTime
                              .add(cancelBookingDuration)
                              .add(Duration(seconds: 3));
                          callApiBeforeCancelBooking(
                              beforeCancelBookingTime.difference(DateTime.now()),
                              cancelBookingDateTime,
                              data.reservationID,
                              data.ploID
                          );
                        }
                        if (data.statusID == 2) {
                          String endTime = convertToDesiredFormat(data.endTime);
                          DateTime endDateTime = DateTime.parse(endTime);
                          DateTime beforeUpdateLater =
                          endDateTime.subtract(Duration(minutes: 1));
                          DateTime afterUpdateStatusLater =
                          endDateTime.add(Duration(seconds: 3));
                          callApiBeforeUpdateStatusLater(
                              beforeUpdateLater.difference(DateTime.now()),
                              afterUpdateStatusLater,
                              data.reservationID,
                              data.ploID
                          );
                        }
                    }
                  });
                });
              }
            },
          );
        }
      },
    );
  }
}

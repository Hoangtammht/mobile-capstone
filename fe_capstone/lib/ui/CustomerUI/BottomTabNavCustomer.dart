import 'dart:async';
import 'dart:convert';

import 'package:fe_capstone/apis/customer/HomeAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/base_constant.dart';
import 'package:fe_capstone/models/CustomerHome.dart';
import 'package:fe_capstone/ui/CustomerUI/CustomerNotificationScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/HistoryScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/HomeScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/ProfileScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/WalletScreen.dart';
import 'package:flutter/material.dart';
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
                      WebSocketChannel channel = IOWebSocketChannel.connect(
                          BaseConstants.WEBSOCKET_PRIVATE_RESERVATION_URL);
                      bool isLoggedIn = UserPreferences.isLoggedIn();
                      if (isLoggedIn) {
                        const duration = Duration(seconds: 45);
                        Timer.periodic(duration, (Timer t) {
                          final message = {
                            "reservationID": data.reservationID.toString(),
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

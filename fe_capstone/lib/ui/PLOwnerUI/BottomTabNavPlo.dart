import 'package:fe_capstone/ui/PLOwnerUI/NotRegisterParkingHomeScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/NotificationScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/ParkingScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloHomeScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloProfileScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/RevenueScreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomTabNavPlo extends StatefulWidget {
  @override
  State<BottomTabNavPlo> createState() => _BottomTabNavPloState();
}

class _BottomTabNavPloState extends State<BottomTabNavPlo> {
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      PloHomeScreen(),
      ParkingScreen(),
      RevenueScreen(),
      PloProfileScreen(),
      NotificationScreen()
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
        icon: const Icon(Icons.receipt_long_outlined),
        title: 'Bãi xe',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_balance_wallet_outlined),
        title: 'Doanh thu',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline_outlined),
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
    );
  }
}

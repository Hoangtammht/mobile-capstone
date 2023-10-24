import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/ui/CustomerUI/CustomerNotificationScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/HistoryScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/HomeScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/ProfileScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/WalletScreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomTabNavCustomer extends StatefulWidget {
  @override
  State<BottomTabNavCustomer> createState() => _BottomTabNavCustomerState();
}

class _BottomTabNavCustomerState extends State<BottomTabNavCustomer> {
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);


  @override
  void initState() {
    super.initState();
    FirebaseAPI.getFirebaseMessagingToken();
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      HistoryScreen(),
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

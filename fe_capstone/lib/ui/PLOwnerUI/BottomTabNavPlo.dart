import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/models/ParkingStatusInformation.dart';
import 'package:fe_capstone/ui/PLOwnerUI/ContractExpiredScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/NotRegisterParkingHomeScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/NotificationScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/ParkingScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloHomeScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloProfileScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/RevenueScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/WaitingApprovalScreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomTabNavPlo extends StatefulWidget {
  @override
  State<BottomTabNavPlo> createState() => _BottomTabNavPloState();
}

class _BottomTabNavPloState extends State<BottomTabNavPlo> with AutomaticKeepAliveClientMixin{
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);
  late Future<ParkingStatusInformation> statusParkingFuture;
  int parkingStatusID = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    statusParkingFuture = _getParkingInformationFuture();
  }

  Future<ParkingStatusInformation> _getParkingInformationFuture() async {
      return ParkingAPI.getParkingStatusID();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ParkingStatusInformation>(
      future: statusParkingFuture,
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
          parkingStatusID = snapshot.data?.parkingStatusID ?? 0;
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
              if(_controller.index == 0 || _controller.index == 1) {
                setState(() {
                  statusParkingFuture = _getParkingInformationFuture();
                });
              }
            },
          );
        }
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      if (parkingStatusID == 1)
        NotRegisterParkingHomeScreen()
      else if (parkingStatusID == 2)
        WaitingApprovalScreen()
      else if (parkingStatusID == 6)
          ContractExpiredScreen()
        else
          PloHomeScreen(),
      ParkingScreen(),
      RevenueScreen(),
      PloProfileScreen(),
      NotificationScreen(),
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
  
}

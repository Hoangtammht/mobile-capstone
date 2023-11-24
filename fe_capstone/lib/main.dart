import 'package:fe_capstone/blocs/VehicleProvider.dart';
import 'package:fe_capstone/blocs/WalletDataProvider.dart';
import 'package:fe_capstone/ui/CustomerUI/BottomTabNavCustomer.dart';
import 'package:fe_capstone/ui/CustomerUI/HomeScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/BottomTabNavPlo.dart';
import 'package:fe_capstone/ui/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'blocs/UserPreferences.dart';
import 'firebase_options.dart';

late Size mq;
late double fem;
late double ffem;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  await UserPreferences.init();
  bool isLoggedIn = UserPreferences.isLoggedIn();
  String? username =  await UserPreferences.getUsername();
  String actualUsername = username ?? '';
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VehicleProvider()),
        ChangeNotifierProvider(create: (context) => WalletDataProvider()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn, username: actualUsername),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String username;
  const MyApp({required this.isLoggedIn , required this.username, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    mq = MediaQuery.of(context).size;
    fem = mq.width / baseWidth;
    ffem = fem * 0.72;
    return MaterialApp(
      title: 'Capstone Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF6EC2F7)
      ),
      home:isLoggedIn ? getHomeScreen() : LoginScreen(),
    );
  }

  Widget getHomeScreen() {
    if (username.contains('P')) {
      return BottomTabNavPlo();
    } else {
      return BottomTabNavCustomer();
    }
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

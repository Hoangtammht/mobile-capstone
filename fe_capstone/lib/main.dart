import 'package:fe_capstone/ui/screens/ChatScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/BottomTabNavCustomer.dart';
import 'package:fe_capstone/ui/CustomerUI/HomeScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/VechicleScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/WalletScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/BottomTabNavPlo.dart';
import 'package:fe_capstone/ui/PLOwnerUI/ContractExpiredScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloChatScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloHomeScreen.dart';
import 'package:fe_capstone/ui/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'blocs/UserPreferences.dart';
import 'firebase_options.dart';

late Size mq;
late double fem;
late double ffem;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    mq = MediaQuery.of(context).size;
    fem = mq.width / baseWidth;
    ffem = fem * 0.87;
    return MaterialApp(
      title: 'Capstone Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF6EC2F7)
      ),
      home: LoginScreen(),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

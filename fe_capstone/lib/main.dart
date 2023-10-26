import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/blocs/VehicleProvider.dart';
import 'package:fe_capstone/blocs/WalletDataProvider.dart';
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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VehicleProvider()),
        ChangeNotifierProvider(create: (context) => WalletDataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
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

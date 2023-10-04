import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/CustomerUI/HomeScreen.dart';
import 'package:flutter/material.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0 * fem,
        top: 0 * fem,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              129 * fem, 43 * fem, 129 * fem, 85 * fem),
          width: mq.width,
          height: 320 * fem,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(23 * fem),
              bottomLeft: Radius.circular(23 * fem)
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
  }
}

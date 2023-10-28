import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class Dialogs {

  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15 * fem
          ),
        ),
        backgroundColor: Colors.blue.withOpacity(.8),
        behavior: SnackBarBehavior.fixed,
        margin: EdgeInsets.only(bottom: 100.0 * fem),
      ),
    );
  }



}

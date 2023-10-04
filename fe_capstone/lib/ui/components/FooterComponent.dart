import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class FooterComponent extends StatelessWidget {
  const FooterComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height:  65*fem,
      decoration:  const BoxDecoration (
        color:  Color(0xFF6EC2F7),
      ),
      child:
      Center(
        child:
        Text(
          'Hotline: 0357280618',
          style:  TextStyle (
            fontSize:  16*ffem,
            fontWeight:  FontWeight.w500,
            height:  1.2175*ffem/fem,
            color:  const Color(0xffffffff),
          ),
        ),
      ),
    );
  }
}

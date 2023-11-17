import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/CustomerUI/HistoryList.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  final VoidCallback? onNavigateToHomeScreen;
  const HistoryScreen({Key? key, this.onNavigateToHomeScreen}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'VÉ ĐẬU XE',
          style: TextStyle(
            fontSize: 30 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: HistoryList(onNavigateToHomeScreen: widget.onNavigateToHomeScreen),
    );
  }
}

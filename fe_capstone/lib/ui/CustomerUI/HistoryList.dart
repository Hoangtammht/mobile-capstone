import 'package:fe_capstone/apis/customer/HistoryAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/History.dart';
import 'package:fe_capstone/models/HistoryDetail.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/HistoryCard.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  Future<List<History>>? historyListFuture;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   historyListFuture = _getListHistoryFuture();
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    historyListFuture = _getListHistoryFuture();
  }

  Future<List<History>> _getListHistoryFuture() async {
    return HistoryAPI.getHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: mq.height,
        width: mq.width,
        child: FutureBuilder<List<History>>(
          future: historyListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            } else {

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return HistoryCard(history: snapshot.data![index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

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
  late Future<List<History>> historyListFuture;
  late List<History> displayedHistory;
  int selectedButtonIndex = 0;

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
              List<History> historyList = snapshot.data!;
              if(selectedButtonIndex == 0){
                displayedHistory = historyList;
              } else if (selectedButtonIndex == 1){
                displayedHistory = historyList
                    .where((history) => history.statusID == 4)
                    .toList();
              } else {
                displayedHistory = historyList
                    .where((history) => history.statusID == 5)
                    .toList();
              }
              return Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedButtonIndex = 0;
                              });
                            },
                            style: selectedButtonIndex == 0
                                ? ElevatedButton.styleFrom(
                                    primary: Colors.green)
                                : null,
                            child: Text('Tất cả'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedButtonIndex = 1;
                              });
                            },
                            style: selectedButtonIndex == 1
                                ? ElevatedButton.styleFrom(
                                    primary: Colors.green)
                                : null,
                            child: Text('Hoàn thành'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedButtonIndex = 2;
                              });
                            },
                            style: selectedButtonIndex == 2
                                ? ElevatedButton.styleFrom(
                                    primary: Colors.green)
                                : null,
                            child: Text('Hủy bỏ'),
                          ),
                        ],
                      )),
                  Expanded(
                      child: ListView.builder(
                    itemCount: displayedHistory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HistoryCard(history: displayedHistory[index]);
                    },
                  )),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

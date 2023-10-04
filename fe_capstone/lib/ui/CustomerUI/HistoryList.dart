import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/History.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/HistoryCard.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final List<History> historyData = [
    History(
      title: 'Khách sạn No Romantic',
      address: '681A Đường Nguyễn Huệ, Bến Nghé, Quận 1, TP HCM',
      status: 'Ban ngày',
      date: 'Từ 3 tiếng trước',
    ),
    History(
      title: 'Khách sạn ABC',
      address: '123 Đường ABC, Quận XYZ, TP HCM',
      status: 'Ban Đêm',
      date: 'Từ 5 tiếng trước',
    ),
    History(
      title: 'Nhà hàng XYZ',
      address: '456 Đường XYZ, Quận ABC, TP HCM',
      status: 'Qua đêm',
      date: 'Từ 1 ngày trước',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: mq.height,
        width: mq.width,
        child: ListView.builder(
          itemCount: historyData.length,
          itemBuilder: (BuildContext context, int index) {
            return HistoryCard(history: historyData[index]);
          },
        ),
      ),
    );
  }
}

import 'package:fe_capstone/ui/components/widgetPLO/ParkingCard.dart';
import 'package:flutter/material.dart';

class ParkingPresent extends StatelessWidget {
  final List<String> type;
  const ParkingPresent({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return ParkingCard(type: type,);
        },
      ),
    );
  }
}

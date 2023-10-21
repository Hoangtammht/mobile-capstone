import 'package:fe_capstone/models/ListVehicleInParking.dart';
import 'package:fe_capstone/ui/components/widgetPLO/ParkingCard.dart';
import 'package:flutter/material.dart';

class ParkingPresent extends StatefulWidget {
  final List<String> type;
  final List<ListVehicleInParking> vehicleList;
  final void Function() updateUI;
  const ParkingPresent({Key? key, required this.type, required this.vehicleList, required this.updateUI}) : super(key: key);

  @override
  State<ParkingPresent> createState() => _ParkingPresentState();
}

class _ParkingPresentState extends State<ParkingPresent> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.vehicleList.length,
        itemBuilder: (BuildContext context, int index) {
          return ParkingCard(type: widget.type, vehicleData: widget.vehicleList[index], updateUI: widget.updateUI);
        },
      ),
    );
  }
}

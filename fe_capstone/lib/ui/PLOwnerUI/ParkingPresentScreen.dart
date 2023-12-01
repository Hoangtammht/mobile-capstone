import 'package:fe_capstone/models/ListVehicleInParking.dart';
import 'package:fe_capstone/ui/components/widgetPLO/ParkingCard.dart';
import 'package:flutter/material.dart';

class ParkingPresent extends StatefulWidget {
  final List<String> type;
  final List<ListVehicleInParking> vehicleList;
  final void Function() updateUI;

  const ParkingPresent({
    Key? key,
    required this.type,
    required this.vehicleList,
    required this.updateUI,
  }) : super(key: key);

  @override
  State<ParkingPresent> createState() => _ParkingPresentState();
}

class _ParkingPresentState extends State<ParkingPresent> {
  late List<ListVehicleInParking> filteredList;

  @override
  void initState() {
    super.initState();
    filteredList = List.from(widget.vehicleList);
  }

  void filterList(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        filteredList = List.from(widget.vehicleList);
      } else {
        filteredList = widget.vehicleList
            .where((vehicle) =>
            vehicle.licensePlate.toLowerCase().contains(searchTerm.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.type.contains('History')
          ? AppBar(
        backgroundColor: Colors.grey[400],
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              onChanged: (value) {
                filterList(value);
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm biển số xe...',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
        ),
      )
          : null,
      body: widget.type.contains('History') ? ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (BuildContext context, int index) {
          return ParkingCard(
            type: widget.type,
            vehicleData: filteredList[index],
            updateUI: widget.updateUI,
          );
        },
      ) :
      ListView.builder(
        itemCount: widget.vehicleList.length,
        itemBuilder: (BuildContext context, int index) {
          return ParkingCard(
            type: widget.type,
            vehicleData: widget.vehicleList[index],
            updateUI: widget.updateUI,
          );
        },
      )
      ,
    );
  }
}



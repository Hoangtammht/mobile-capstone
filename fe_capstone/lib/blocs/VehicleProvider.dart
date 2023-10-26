import 'package:fe_capstone/apis/customer/VehicleAPI.dart';
import 'package:fe_capstone/models/ListVehicleCustomer.dart';
import 'package:flutter/material.dart';

class VehicleProvider extends ChangeNotifier {
  List<ListVehicleCustomer> vehicles = [];

  Future<List<ListVehicleCustomer>> getVehicleList() async {
    return vehicles = await VehicleAPI.getVehicleList();
  }

  Future<void> addNewVehicle(String licensePlate) async {
    await VehicleAPI.addNewLicencePlate(licensePlate);
    await getVehicleList();
  }

  Future<void> deleteVehicle(int vehicleID) async {
    await VehicleAPI.deleteNewLicencePlate(vehicleID);
    await getVehicleList();
  }
}

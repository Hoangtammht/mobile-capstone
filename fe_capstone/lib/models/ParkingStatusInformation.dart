class ParkingStatusInformation {
  ParkingStatusInformation({
    required this.parkingStatusID,
    required this.statusName,
    required this.totalVehicle,
    required this.totalComing,
  });
  late final int parkingStatusID;
  late final String statusName;
  late final int totalVehicle;
  late final List<TotalComing> totalComing;

  ParkingStatusInformation.fromJson(Map<String, dynamic> json){
    parkingStatusID = json['parkingStatusID'] ?? 0;
    statusName = json['statusName']?? '';
    totalVehicle = json['totalVehicle']?? 0;
    totalComing = (json['totalComing'] != null && json['totalComing'].isNotEmpty)
        ? List.from(json['totalComing']).map((e) => TotalComing.fromJson(e)).toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['parkingStatusID'] = parkingStatusID;
    _data['statusName'] = statusName;
    _data['totalVehicle'] = totalVehicle;
    _data['totalComing'] = totalComing.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class TotalComing {
  TotalComing({
    required this.reservationID,
    required this.licensePlate,
    required this.fullName,
    required this.methodName,
  });
  late final int reservationID;
  late final String licensePlate;
  late final String fullName;
  late final String methodName;

  TotalComing.fromJson(Map<String, dynamic> json){
    reservationID = json['reservationID'] ?? 0;
    licensePlate = json['licensePlate']?? '';
    fullName = json['fullName'] ?? '';
    methodName = json['methodName']?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reservationID'] = reservationID;
    _data['licensePlate'] = licensePlate;
    _data['fullName'] = fullName;
    _data['methodName'] = methodName;
    return _data;
  }
}
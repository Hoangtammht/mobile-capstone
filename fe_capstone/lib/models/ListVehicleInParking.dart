class ListVehicleInParking {
  ListVehicleInParking({
    required this.reservationID,
    required this.customerID,
    required this.fullName,
    required this.price,
    required this.phoneNumber,
    required this.licensePlate,
    required this.startTime,
    required this.endTime,
    required this.methodName,
    required this.statusName,
  });
  late final String reservationID;
  late final String customerID;
  late final String fullName;
  late final double price;
  late final String phoneNumber;
  late final String licensePlate;
  late final String startTime;
  late final String endTime;
  late final String methodName;
  late final String statusName;

  ListVehicleInParking.fromJson(Map<String, dynamic> json) {
    reservationID = json['reservationID'] ?? '';
    customerID = json['customerID'] ?? '';
    fullName = json['fullName'] ?? '';
    price = json['price'] ?? 0.0;
    phoneNumber = json['phoneNumber'] ?? '';
    licensePlate = json['licensePlate'] ?? '';
    startTime = json['startTime'] ?? '';
    endTime = json['endTime'] ?? '';
    methodName = json['methodName'] ?? '';
    statusName = json['statusName'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reservationID'] = reservationID;
    _data['customerID'] = customerID;
    _data['fullName'] = fullName;
    _data['price'] = price;
    _data['phoneNumber'] = phoneNumber;
    _data['licensePlate'] = licensePlate;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['methodName'] = methodName;
    _data['statusName'] = statusName;
    return _data;
  }
}
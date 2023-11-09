class ListVehicleCustomer {
  ListVehicleCustomer({
    required this.motorbikeID,
    required this.licensePlate,
  });
  late final int motorbikeID;
  late final String licensePlate;


  ListVehicleCustomer.fromJson(Map<String, dynamic> json) {
    motorbikeID = json['motorbikeID'] ?? '';
    licensePlate = json['licensePlate'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['motorbikeID'] = motorbikeID;
    _data['licensePlate'] = licensePlate;
    return _data;
  }
}
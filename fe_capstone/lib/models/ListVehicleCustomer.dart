class ListVehicleCustomer {
  ListVehicleCustomer({
    required this.motorbikeID,
    required this.licensePlate,
    required this.motorbikeName,
    required this.motorbikeColor,
  });
  late final int motorbikeID;
  late final String licensePlate;
  late final String motorbikeName;
  late final String motorbikeColor;
  ListVehicleCustomer.fromJson(Map<String, dynamic> json) {
    motorbikeID = json['motorbikeID'] ?? '';
    licensePlate = json['licensePlate'] ?? '';
    motorbikeName = json['motorbikeName'] ?? '';
    motorbikeColor = json['motorbikeColor'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['motorbikeID'] = motorbikeID;
    _data['licensePlate'] = licensePlate;
    _data['motorbikeName'] = motorbikeName;
    _data['motorbikeColor'] = motorbikeColor;
    return _data;
  }
}
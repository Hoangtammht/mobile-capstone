class ReservationDetail {
  ReservationDetail({
    required this.licensePlate,
    required this.price,
    required this.methodName,
    required this.fullName,
    required this.phoneNumber,
    required this.statusName,
    required this.startTime,
    required this.endTime,
    required this.checkIn,
    required this.checkOut,
  });
  late final String licensePlate;
  late final double price;
  late final String methodName;
  late final String fullName;
  late final String phoneNumber;
  late final String statusName;
  late final String startTime;
  late final String endTime;
  late final String checkIn;
  late final String checkOut;

  ReservationDetail.fromJson(Map<String, dynamic> json){
    licensePlate = json['licensePlate'] ?? '';
    price = json['price'] ?? 0.0;
    methodName = json['methodName'] ?? '';
    fullName = json['fullName'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    statusName = json['statusName'] ?? '';
    startTime = json['startTime'] ?? '';
    endTime = json['endTime'] ?? '';
    checkIn = json['checkIn'] ?? '';
    checkOut = json['checkOut'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['licensePlate'] = licensePlate;
    _data['price'] = price;
    _data['methodName'] = methodName;
    _data['fullName'] = fullName;
    _data['phoneNumber'] = phoneNumber;
    _data['statusName'] = statusName;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['checkIn'] = checkIn;
    _data['checkOut'] = checkOut;
    return _data;
  }
}
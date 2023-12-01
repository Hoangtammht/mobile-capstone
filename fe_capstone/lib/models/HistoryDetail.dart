class HistoryDetail {
  late final String parkingName;
  late final double fee;
  late final String address;
  late final String methodName;
  late final String licensePlate;
  late final String statusName;
  late final String checkIn;
  late final String checkOut;
  late final String startTime;
  late final String endTime;


  HistoryDetail({
    required this.parkingName,
    required this.fee,
    required this.address,
    required this.methodName,
    required this.licensePlate,
    required this.statusName,
    required this.checkIn,
    required this.checkOut,
    required this.startTime,
    required this.endTime,
  });

  factory HistoryDetail.fromJson(Map<String, dynamic> json){
    return HistoryDetail(
      parkingName: json['parkingName'] ?? '',
      fee: json['fee'] ?? 0.0,
      address: json['address'] ?? '',
      methodName: json['methodName'] ?? '',
      licensePlate: json['licensePlate'] ?? '',
      statusName: json['statusName'] ?? '',
      checkIn: json['checkIn'] ?? '',
      checkOut: json['checkOut'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['parkingName'] = parkingName;
    _data['fee'] = fee;
    _data['address'] = address;
    _data['methodName'] = methodName;
    _data['licensePlate'] = licensePlate;
    _data['statusName'] = statusName;
    _data['checkIn'] = checkIn;
    _data['checkOut'] = checkOut;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    return _data;
  }
}
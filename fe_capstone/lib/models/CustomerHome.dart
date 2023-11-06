class CustomerHome {
  CustomerHome({
    required this.reservationID,
    required this.ploID,
    required this.statusID,
    required this.statusName,
    required this.parkingName,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.price,
    required this.methodName,
    required this.licensePlate,
  });

  late final int reservationID;
  late final String ploID;
  late final int statusID;
  late final String statusName;
  late final String parkingName;
  late final String startTime;
  late final String endTime;
  late final String waitingTime;
  late final String cancelBookingTime;
  late final String address;
  late final double longitude;
  late final double latitude;
  late final double price;
  late final String methodName;
  late final String licensePlate;


  CustomerHome.fromJson(Map<String, dynamic> json){
    reservationID = json['reservationID'] ?? '';
    ploID = json['ploID'] ?? '';
    statusID = json['statusID'] ?? '';
    statusName = json['statusName'] ?? '';
    parkingName = json['parkingName'] ?? '';
    startTime = json['startTime'] ?? '';
    endTime = json['endTime'] ?? '';
    waitingTime = json['waitingTime'] ?? '';
    cancelBookingTime = json['cancelBookingTime'] ?? '';
    address = json['address'] ?? '';
    longitude = json['longitude'] ?? '';
    latitude = json['latitude'] ?? '';
    price = json['price'] ?? '';
    methodName = json['methodName'] ?? '';
    licensePlate = json['licensePlate'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reservationID'] = reservationID;
    _data['ploID'] = ploID;
    _data['statusID'] = statusID;
    _data['statusName'] = statusName;
    _data['parkingName'] = parkingName;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['waitingTime'] = waitingTime;
    _data['cancelBookingTime'] = cancelBookingTime;
    _data['address'] = address;
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['price'] = price;
    _data['methodName'] = methodName;
    _data['licensePlate'] = licensePlate;
    return _data;
  }
}
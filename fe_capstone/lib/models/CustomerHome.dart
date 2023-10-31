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
    _data['address'] = address;
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['price'] = price;
    _data['methodName'] = methodName;
    _data['licensePlate'] = licensePlate;
    return _data;
  }
}
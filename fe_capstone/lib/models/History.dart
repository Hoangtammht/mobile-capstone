class History {
  late final int reservationID;
  late final String parkingName;
  late final String address;
  late final String methodName;
  late final String checkIn;
  late final String checkOut;
  late final int statusID;
  History({
    required this.reservationID,
    required this.parkingName,
    required this.address,
    required this.methodName,
    required this.checkIn,
    required this.checkOut,
    required this.statusID,

  });

  History.fromJson(Map<String, dynamic> json){
    reservationID = json['reservationID'] ?? 0;
    parkingName = json['parkingName'] ?? '';
    address = json['address'] ?? '';
    methodName = json['methodName'] ?? '';
    checkIn = json['checkIn'] ?? '';
    checkOut = json['checkOut'] ?? '';
    statusID = json['statusID'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reservationID'] = reservationID;
    _data['parkingName'] = parkingName;
    _data['address'] = address;
    _data['methodName'] = methodName;
    _data['checkIn'] = checkIn;
    _data['checkOut'] = checkOut;
    _data['statusID'] = statusID;
    return _data;
  }
}



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
    required this.totalPrice,
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
  late final double totalPrice;

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
    totalPrice = json['totalPrice'] ?? 0.0;
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
    _data['totalPrice'] = totalPrice;
    return _data;
  }
}


class ReservationByLicensePlate {
  ReservationByLicensePlate({
    required this.customerID,
    required this.reservationID,
    required this.customerName,
    required this.methodName,
    required this.status,
    required this.statusName,
    required this.checkIn,
    required this.checkOut,
    required this.licensePlate,
  });
  late final String customerID;
  late final int reservationID;
  late final String customerName;
  late final String methodName;
  late final int status;
  late final String statusName;
  late final String checkIn;
  late final String checkOut;
  late final String licensePlate;

  ReservationByLicensePlate.fromJson
      (Map<String, dynamic> json){
    customerID = json['customerID'] ?? '';
    reservationID = json['reservationID'] ?? 0;
    customerName = json['customerName'] ?? '';
    methodName = json['methodName'] ?? '';
    status = json['status'] ?? 0;
    statusName = json['statusName'] ?? '';
    checkIn = json['checkIn'] ?? '';
    checkOut = json['checkOut'] ?? '';
    licensePlate = json['licensePlate'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerID'] = customerID;
    _data['reservationID'] = reservationID;
    _data['customerName'] = customerName;
    _data['licensePlate'] = licensePlate;
    _data['methodName'] = methodName;
    _data['status'] = status;
    _data['statusName'] = statusName;
    _data['checkIn'] = checkIn;
    _data['checkOut'] = checkOut;
    return _data;
  }
}

class ReservationMethod {
  ReservationMethod({
    required this.methodID,
    required this.methodName,
    required this.price,
    required this.special,
  });

  late final int methodID;
  late final String methodName;
  late final double price;
  late final bool special;

  ReservationMethod.fromJson
      (Map<String, dynamic> json){
    methodID = json['methodID'] ?? 0;
    methodName = json['methodName'] ?? '';
    price = json['price'] ?? 0;
    special = json['special'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['methodID'] = methodID;
    _data['methodName'] = methodName;
    _data['price'] = price;
    _data['special'] = special;
    return _data;
  }
}


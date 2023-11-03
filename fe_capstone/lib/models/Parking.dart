import 'package:fe_capstone/models/History.dart';

class Parking {
  Parking({
    required this.ploID,
    required this.parkingName,
    required this.currentSlot,
    required this.address,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.currentTime,
    required this.methodName,
    required this.slot,
    required this.listMethod,

  });
  late final String ploID;
  late final String parkingName;
  late final int currentSlot;
  late final String address;
  late final double distance;
  late final double latitude;
  late final double longitude;
  late final double price;
  late final String currentTime;
  late final String methodName;
  late final int slot;
  late final List<Method> listMethod;

  Parking.fromJson(Map<String, dynamic> json){
    ploID = json['ploID'] ?? '';
    parkingName = json['parkingName'] ?? '';
    currentSlot = json['currentSlot'] ?? 0;
    address = json['address'] ?? '';
    distance = json['distance'] ?? 0.0;
    price = json['price'] ?? 0.0;
    latitude = json['latitude'] ?? 0.0;
    longitude = json['longitude'] ?? 0.0;
    currentTime = json['currentTime'] ?? '';
    methodName = json['methodName'] ?? '';
    slot = json['slot'] ?? 0;
    listMethod = (json['listMethod'] as List<dynamic>?)
        ?.map((e) => Method.fromJson(e as Map<String, dynamic>))
        .toList() ?? [];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ploID'] = ploID;
    _data['parkingName'] = parkingName;
    _data['currentSlot'] = currentSlot;
    _data['address'] = address;
    _data['distance'] = distance;
    _data['price'] = price;
    _data['currentTime'] = currentTime;
    _data['methodName'] = methodName;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['slot'] = slot;
    _data['listMethod'] = listMethod.map((e) => e.toJson()).toList();
    return _data;
  }
}


class Method {
  Method({
    required this.methodID,
    required this.methodName,
    required this.price,
  });
  late final int methodID;
  late final String methodName;
  late final double price;


  Method.fromJson(Map<String, dynamic> json){
    methodID = json['methodID'] ?? 0;
    methodName = json['methodName'] ?? '';
    price = json['price'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['methodID'] = methodID;
    _data['methodName'] = methodName;
    _data['price'] = price;
    return _data;
  }
}
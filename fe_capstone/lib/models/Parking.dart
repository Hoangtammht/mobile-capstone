class Parking {
  Parking({
    required this.parkingName,
    required this.currentSlot,
    required this.address,
    required this.distance,
    required this.price,
    required this.currentTime,
    required this.methodName,
    required this.slot,
  });
  late final String parkingName;
  late final int currentSlot;
  late final String address;
  late final double distance;
  late final double price;
  late final String currentTime;
  late final String methodName;
  late final int slot;

  Parking.fromJson(Map<String, dynamic> json){
    parkingName = json['parkingName'] ?? '';
    currentSlot = json['currentSlot'] ?? 0;
    address = json['address'] ?? '';
    distance = json['distance'] ?? 0.0;
    price = json['price'] ?? 0.0;
    currentTime = json['currentTime'] ?? '';
    methodName = json['methodName'] ?? '';
    slot = json['slot'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['parkingName'] = parkingName;
    _data['currentSlot'] = currentSlot;
    _data['address'] = address;
    _data['distance'] = distance;
    _data['price'] = price;
    _data['currentTime'] = currentTime;
    _data['methodName'] = methodName;
    _data['slot'] = slot;
    return _data;
  }
}
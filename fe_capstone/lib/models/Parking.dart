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
    return _data;
  }
}
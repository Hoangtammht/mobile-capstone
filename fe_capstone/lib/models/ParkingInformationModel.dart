class ParkingInformationModel {
  ParkingInformationModel({
    required this.ploID,
    required this.parkingName,
    required this.description,
    required this.address,
    required this.slot,
    required this.length,
    required this.width,
    required this.image,
    required this.waitingTime,
    required this.cancelBookingTime,
  });
  late final String ploID;
  late final String parkingName;
  late final String description;
  late final String address;
  late final int slot;
  late final double length;
  late final double width;
  late final List<ParkingImage> image;
  late final String waitingTime;
  late final String cancelBookingTime;

  ParkingInformationModel.fromJson(Map<String, dynamic> json){
    ploID = json['ploID'] ?? '';
    parkingName = json['parkingName'] ?? '';
    description = json['description'] ?? '';
    address = json['address'] ?? '';
    slot = json['slot'] != null ? json['slot'] : 0;
    length = json['length'] != null ? json['length'] : 0.0;
    width = json['width'] != null ? json['width'] : 0.0;
    waitingTime = json['waitingTime'] ?? '';
    cancelBookingTime = json['cancelBookingTime'] ?? '';
    if (json['image'] is List) {
      image = List.from(json['image']).map((e) => ParkingImage.fromJson(e)).toList();
    } else {
      image = <ParkingImage>[];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ploID'] = ploID;
    _data['parkingName'] = parkingName;
    _data['description'] = description;
    _data['address'] = address;
    _data['slot'] = slot;
    _data['length'] = length;
    _data['width'] = width;
    _data['waitingTime'] = waitingTime;
    _data['cancelBookingTime'] = cancelBookingTime;
    _data['image'] = image.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ParkingImage {
  ParkingImage({
    required this.imageID,
    required this.ploID,
    required this.imageLink,
  });
  late final int imageID;
  late final String ploID;
  late final String imageLink;

  ParkingImage.fromJson(Map<String, dynamic> json){
    imageID = json['imageID'];
    ploID = json['ploID'];
    imageLink = json['imageLink'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageID'] = imageID;
    _data['ploID'] = ploID;
    _data['imageLink'] = imageLink;
    return _data;
  }
}
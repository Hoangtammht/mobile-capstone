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


class ParkingImage2 {
  ParkingImage2({
    required this.imageID,
    required this.imageLink,
  });
  late final int imageID;
  late final String imageLink;

  ParkingImage2.fromJson(Map<String, dynamic> json){
    imageID = json['imageID'];
    imageLink = json['imageLink'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageID'] = imageID;
    _data['imageLink'] = imageLink;
    return _data;
  }
}

class ParkingHomeScreen {
  ParkingHomeScreen({
    required this.ploID,
    required this.parkingName,
    required this.address,
    required this.slot,
  });
  late final String ploID;
  late final String parkingName;
  late final String address;
  late final int slot;


  ParkingHomeScreen.fromJson(Map<String, dynamic> json){
    ploID = json['ploID'];
    parkingName = json['parkingName'];
    address = json['address'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ploID'] = ploID;
    _data['parkingName'] = parkingName;
    _data['address'] = address;
    _data['slot'] = slot;
    return _data;
  }
}


class ParkingLotDetail {
  ParkingLotDetail({
    required this.parkingName,
    required this.address,
    required this.morningFee,
    required this.eveningFee,
    required this.overnightFee,
    required this.star,
    required this.currentSlot,
    required this.images,
  });

  late final String parkingName;
  late final String address;
  late final double morningFee;
  late final double eveningFee;
  late final double overnightFee;
  late final int star;
  late final int currentSlot;
  late final List<ParkingImage2> images;



  ParkingLotDetail.fromJson(Map<String, dynamic> json){
    parkingName = json['parkingName'];
    address = json['address'];
    morningFee = json['morningFee'];
    eveningFee = json['eveningFee'];
    overnightFee = json['overnightFee'];
    star = json['star'];
    currentSlot = json['currentSlot'];
    if (json['images'] is List) {
      images = List.from(json['images']).map((e) => ParkingImage2.fromJson(e)).toList();
    } else {
      images = <ParkingImage2>[];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['parkingName'] = parkingName;
    _data['address'] = address;
    _data['morningFee'] = morningFee;
    _data['eveningFee'] = eveningFee;
    _data['overnightFee'] = overnightFee;
    _data['star'] = star;
    _data['currentSlot'] = currentSlot;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    return _data;
  }
}
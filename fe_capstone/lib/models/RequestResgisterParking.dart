class RequestRegisterParking {
  final String address;
  final String description;
  final List<String> images;
  final double length;
  final String parkingName;
  final String ploID;
  final int slot;
  final String uuid;
  final double width;

  RequestRegisterParking({
    required this.address,
    required this.description,
    required this.images,
    required this.length,
    required this.parkingName,
    required this.ploID,
    required this.slot,
    required this.uuid,
    required this.width,
  });

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "description": description,
      "images": images,
      "length": length,
      "parkingName": parkingName,
      "ploID": ploID,
      "slot": slot,
      "uuid": uuid,
      "width": width,
    };
  }
}

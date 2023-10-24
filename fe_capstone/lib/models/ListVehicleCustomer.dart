class ListVehicleCustomer {
  ListVehicleCustomer({
    required this.licencePlateID,
    required this.licencePlate,
  });
  late final int licencePlateID;
  late final String licencePlate;


  ListVehicleCustomer.fromJson(Map<String, dynamic> json) {
    licencePlateID = json['licencePlateID'] ?? '';
    licencePlate = json['licencePlate'] ?? '';

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['licencePlateID'] = licencePlateID;
    _data['licencePlate'] = licencePlate;
    return _data;
  }
}
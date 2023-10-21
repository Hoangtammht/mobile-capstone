class PloProfile {
  PloProfile({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
  });
  late final String fullName;
  late final String phoneNumber;
  late final String email;

  PloProfile.fromJson(Map<String, dynamic> json){
    fullName = json['fullName'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fullName'] = fullName;
    _data['phoneNumber'] = phoneNumber;
    _data['email'] = email;
    return _data;
  }
}
class UpdateProfileRequest {
  final String email;
  final String fullName;

  UpdateProfileRequest({
    required this.email,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
    };
  }
}

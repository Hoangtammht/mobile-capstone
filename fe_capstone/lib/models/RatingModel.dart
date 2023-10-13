class RatingModel {
  RatingModel({
    required this.ratingID,
    required this.star,
    required this.content,
    required this.customerID,
    required this.ploID,
    required this.reservationID,
    required this.feedbackDate,
  });
  late final int ratingID;
  late final int star;
  late final String content;
  late final String customerID;
  late final String ploID;
  late final String reservationID;
  late final String feedbackDate;

  RatingModel.fromJson(Map<String, dynamic> json){
    ratingID = json['ratingID'] ?? 0;
    star = json['star'] ?? 0;
    content = json['content'] ?? '';
    customerID = json['customerID'] ?? '';
    ploID = json['ploID'] ?? '';
    reservationID = json['reservationID'] ?? 0;
    feedbackDate = json['feedbackDate'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ratingID'] = ratingID;
    _data['star'] = star;
    _data['content'] = content;
    _data['customerID'] = customerID;
    _data['ploID'] = ploID;
    _data['reservationID'] = reservationID;
    _data['feedbackDate'] = feedbackDate;
    return _data;
  }
}
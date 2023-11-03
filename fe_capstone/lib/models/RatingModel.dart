class RatingModel {
  RatingModel({
    required this.ratingID,
    required this.star,
    required this.content,
    required this.customerID,
    required this.fullName,
    required this.ploID,
    required this.reservationID,
    required this.feedbackDate,
  });
  late final int ratingID;
  late final int star;
  late final String content;
  late final String customerID;
  late final String fullName;
  late final String ploID;
  late final int reservationID;
  late final String feedbackDate;

  RatingModel.fromJson(Map<String, dynamic> json){
    ratingID = json['ratingID'] ?? 0;
    star = json['star'] ?? 0;
    content = json['content'] ?? '';
    customerID = json['customerID'] ?? '';
    fullName = json['fullName'] ?? '';
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
    _data['fullName'] = fullName;
    _data['ploID'] = ploID;
    _data['reservationID'] = reservationID;
    _data['feedbackDate'] = feedbackDate;
    return _data;
  }
}


class CustomerRating{
  CustomerRating({
    required this.customerID,
    required this.customerName,
    required this.rating,
    required this.content,
    required this.feedbackDate,
  });
  late final String customerID;
  late final String customerName;
  late final int rating;
  late final String content;
  late final String feedbackDate;

  CustomerRating.fromJson(Map<String, dynamic> json){
    customerID = json['customerID'] ?? '';
    customerName = json['customerName'] ?? '';
    rating = json['rating'] ?? 0;
    content = json['content'] ?? '';
    feedbackDate = json['feedbackDate'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerID'] = customerID;
    _data['customerName'] = customerName;
    _data['rating'] = rating;
    _data['content'] = content;
    _data['feedbackDate'] = feedbackDate;
    return _data;
  }
}
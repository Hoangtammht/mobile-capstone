class CustomerNotification {
  CustomerNotification({
    required this.notiID,
    required this.recipientType,
    required this.recipientId,
    required this.senderType,
    required this.senderName,
    required this.content,
    required this.createdAt,
  });
  late final int notiID;
  late final String recipientType;
  late final String recipientId;
  late final String senderType;
  late final String senderName;
  late final String content;
  late final String createdAt;

  CustomerNotification.fromJson(Map<String, dynamic> json){
    notiID = json['notiID'] ?? 0;
    recipientType = json['recipient_type'] ?? '';
    recipientId = json['recipient_id'] ?? '';
    senderType = json['sender_type'] ?? '';
    senderName = json['senderName'] ?? '';
    content = json['content'] ?? '';
    createdAt = json['created_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['notiID'] = notiID;
    _data['recipient_type'] = recipientType;
    _data['recipient_id'] = recipientId;
    _data['sender_type'] = senderType;
    _data['senderName'] = senderName;
    _data['content'] = content;
    _data['created_at'] = createdAt;
    return _data;
  }
}
class ChatUser {
  ChatUser({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
  });

  late String id;
  late String lastMessage;
  late String name;
  late String time;

  ChatUser.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? '';
    lastMessage = json['lastMessage'] ?? '';
    name = json['name'] ?? '';
    time = json['time'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['lastMessage'] = lastMessage;
    _data['name'] = name;
    _data['time'] = time;
    return _data;
  }
}
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

}
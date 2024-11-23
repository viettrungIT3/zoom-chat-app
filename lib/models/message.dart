class Message {
  final String userId;
  final String message;

  Message({
    required this.userId,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      userId: json['userId'],
      message: json['message'],
    );
  }
}

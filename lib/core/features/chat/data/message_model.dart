class MessageModel {
  final String id;
  final String senderId;
  final String message;
  final DateTime timestamp;
  final bool isMe;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.message,
    required this.timestamp,
    required this.isMe,
  });

  factory MessageModel.fromMap(Map<dynamic, dynamic> map, String id, String currentUserId) {
    return MessageModel(
      id: id,
      senderId: map['senderId'] ?? '',
      message: map['message'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ?? 0),
      isMe: map['senderId'] == currentUserId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
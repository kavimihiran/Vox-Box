class MessageModel {
  final String messageId;
  final String senderId;
  final String senderName; // New field
  final String messageContent;
  final DateTime timestamp;

  MessageModel({
    required this.messageId,
    required this.senderId,
    required this.senderName, // New field
    required this.messageContent,
    required this.timestamp,
  });
}

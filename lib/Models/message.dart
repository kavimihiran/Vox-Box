class MessageModel {
  final String messageId;
  final String senderId;
  final String messageContent;
  final DateTime timestamp;

  MessageModel(
      {required this.messageId,
      required this.senderId,
      required this.messageContent,
      required this.timestamp});
}

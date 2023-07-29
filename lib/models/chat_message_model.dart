class ChatMessage {
  final DateTime time;
  final String message;
  final bool isSent;

  ChatMessage({
    required this.time,
    required this.message,
    this.isSent = false,
  });
}

import 'package:objectbox/objectbox.dart';

@Entity()
class ChatMessage {
  @Id(assignable: true)
  int id = 0;
  final String message;
  final bool isSent;
  @Property(type: PropertyType.date)
  final DateTime time;

  ChatMessage({
    required this.time,
    required this.message,
    this.isSent = false,
  });
}

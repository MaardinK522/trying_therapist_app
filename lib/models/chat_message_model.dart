import 'package:objectbox/objectbox.dart';

@Entity()
class SentMessage {
  @Id(assignable: true)
  int id = 0;
  final int sendersID;
  final String message;
  final bool isSent;
  @Property(type: PropertyType.date)
  final DateTime time;

  SentMessage({
    required this.time,
    required this.message,
    this.isSent = false,
    required this.sendersID,
  });
}

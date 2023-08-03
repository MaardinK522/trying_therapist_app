import 'package:objectbox/objectbox.dart';

@Entity()
class ChatHistoryItemModel {
  @Id(assignable: true)
  int id = 0;

  int personID;

  String lastText;
  @Property(type: PropertyType.date)
  DateTime? lastTextTime;
  int unReadText;

  ChatHistoryItemModel({
    required this.personID,
    required this.lastTextTime,
    required this.lastText,
    required this.unReadText,
  });
}

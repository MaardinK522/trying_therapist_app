import 'package:objectbox/objectbox.dart';

@Entity()
class CallHistoryItemModel {
  @Id(assignable: true)
  int id = 0;
  String personName;
  @Property(type: PropertyType.date)
  DateTime calledTime;
  
  CallHistoryItemModel({required this.personName, required this.calledTime});
}

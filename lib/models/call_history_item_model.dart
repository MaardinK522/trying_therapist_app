import 'package:objectbox/objectbox.dart';
import 'package:therapist_side/models/person_model.dart';

@Entity()
class CallHistoryItemModel {
  @Id(assignable: true)
  int id = 0;
  final person = ToOne<PersonModel>();
  @Property(type: PropertyType.date)
  DateTime calledTime;

  CallHistoryItemModel(
    this.calledTime,
  );
}

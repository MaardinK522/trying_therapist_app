import 'package:objectbox/objectbox.dart';

@Entity()
class MedicineGroupItemModel {
  @Id(assignable: true)
  int id = 0;
  String topic;
  List<String> medicines;
  bool? isExpanded;

  MedicineGroupItemModel({
    required this.topic,
    required this.medicines,
    this.isExpanded = false,
  });
}

import 'package:objectbox/objectbox.dart';

@Entity()
class MedicineGroupListViewItemModel {
  @Id()
  int id = 0;
  final String topic;
  final List<String> medicines;
  @Transient()
  bool? isExpanded;

  MedicineGroupListViewItemModel({
    required this.topic,
    required this.medicines,
    this.isExpanded = false,
  });
}

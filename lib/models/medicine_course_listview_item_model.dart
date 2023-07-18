import 'package:objectbox/objectbox.dart';

@Entity()
class MedicineCourseListViewItemModel {
  @Id()
  int id = 0;
  final String topic;
  final List<String> medicines;
  @Transient()
  bool? isExpanded;

  MedicineCourseListViewItemModel({
    required this.topic,
    required this.medicines,
    this.isExpanded = false,
  });
}

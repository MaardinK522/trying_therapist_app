import 'package:therapist_side/main.dart';
import '../models/medicine_course_listview_item_model.dart';

class MedicineGroupListItemService {
  Future<List<MedicineCourseListViewItemModel>> getAllGroups() async {
    return Future.value(
      objectBox.store.box<MedicineCourseListViewItemModel>().getAll(),
    );
  }

  void addGroup(MedicineCourseListViewItemModel model) {
    objectBox.store.box<MedicineCourseListViewItemModel>().put(model);
  }

  void deleteGroup(MedicineCourseListViewItemModel model) {
    objectBox.store.box<MedicineCourseListViewItemModel>().remove(model.id);
  }
}

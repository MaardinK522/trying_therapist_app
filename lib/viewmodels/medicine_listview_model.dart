import 'package:flutter/cupertino.dart';
import 'package:therapist_side/services/medicine_group_list_item_service.dart';

import '../models/medicine_course_listview_item_model.dart';

class MedicineListViewModel extends ChangeNotifier {
  List<MedicineCourseListViewItemModel>? items = List.empty();

  Future<List<MedicineCourseListViewItemModel>?> fetchAllMedicineItems() async {
    final item = Future.value(MedicineGroupListItemService().getAllGroups());
    notifyListeners();
    return item;
  }

  void addNew(MedicineCourseListViewItemModel item) {
    MedicineGroupListItemService.add(item);
    notifyListeners();
  }
}

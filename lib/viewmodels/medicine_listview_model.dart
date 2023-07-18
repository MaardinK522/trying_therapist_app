import 'package:flutter/cupertino.dart';
import 'package:therapist_side/services/medicine_group_list_item_service.dart';

import '../models/medicine_course_listview_item_model.dart';

class MedicineListViewModel extends ChangeNotifier {
  List<MedicineCourseListViewItemModel>? items = List.empty();

  Future<void> fetchAllMedicineItems() async {
    MedicineGroupListItemService().getAllGroups();
    notifyListeners();
  }
}

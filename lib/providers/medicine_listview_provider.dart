import 'package:flutter/widgets.dart';
import 'package:therapist_side/main.dart';

import '../models/medicine_course_listview_item_model.dart';

class MedicineGroupListViewProvider extends ChangeNotifier {
  static late List<MedicineGroupListViewItemModel> medicineGroupsItems;

  void updateAllMedicineGroupItems() {
    medicineGroupsItems = database.getAllItems();
    notifyListeners();
  }

  Future<void> addItemToList(MedicineGroupListViewItemModel item) async {
    database.putItem(item);
    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    database.removeItem(id);
    notifyListeners();
  }
}

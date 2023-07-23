import 'package:flutter/widgets.dart';
import 'package:therapist_side/main.dart';

import '../models/medicine_course_item_model.dart';

class MedicineGroupListViewProvider extends ChangeNotifier {
  static late List<MedicineGroupItemModel> medicineGroupsItems;

  Future<void> updateAllMedicineGroupItems() async {
    medicineGroupsItems = database.getAllItems<MedicineGroupItemModel>();
    notifyListeners();
  }

  Future<void> addItemToList(MedicineGroupItemModel item) async {
    database.putItem<MedicineGroupItemModel>(item);
    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    database.removeItem<MedicineGroupItemModel>(id);
    notifyListeners();
  }
}

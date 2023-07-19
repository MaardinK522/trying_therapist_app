import 'package:path_provider/path_provider.dart';
import 'package:therapist_side/objectbox.g.dart';
import 'package:path/path.dart' as path;

import '../models/medicine_course_listview_item_model.dart';

class Database {
  late final Store _store;

  Database._create(this._store);

  static Future<Database> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: path.join(docsDir.path, "mk"));
    return Database._create(store);
  }

  List<MedicineGroupListViewItemModel> getAllItems() {
    return _store.box<MedicineGroupListViewItemModel>().getAll();
  }

  putItem(MedicineGroupListViewItemModel item) {
    _store.box<MedicineGroupListViewItemModel>().put(item);
  }

  removeItem(int id) {
    _store.box<MedicineGroupListViewItemModel>().remove(id);
  }
}

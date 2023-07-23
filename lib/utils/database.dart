import 'package:path_provider/path_provider.dart';
import 'package:therapist_side/objectbox.g.dart';
import 'package:path/path.dart' as path;

class Database {
  late final Store _store;

  Database._create(this._store);

  static Future<Database> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: path.join(docsDir.path, "mk"));
    return Database._create(store);
  }

  List<T> getAllItems<T>() {
    return _store.box<T>().getAll();
  }

  putItem<T>(T item) {
    _store.box<T>().put(item);
  }

  removeItem<T>(int id) {
    _store.box<T>().remove(id);
  }
}

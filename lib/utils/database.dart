import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:therapist_side/objectbox.g.dart';

import '../models/person_model.dart';

class Database {
  late final Store _store;

  Database._create(this._store);

  static Future<Database> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: path.join(docsDir.path, "mk"));
    return Database._create(store);
  }

  List<T> getAllItems<T>() => _store.box<T>().getAll();

  putItem<T>(T item) {
    _store.box<T>().put(item);
  }

  removeItem<T>(int id) {
    _store.box<T>().remove(id);
  }

  List<PersonModel> doesChatHistoryItemExists(name) {
    Query<PersonModel> query = _store
        .box<PersonModel>()
        .query(PersonModel_.personName.equals(name))
        .build();
    var items = query.find();
    query.close();
    return items;
  }

  T? getItem<T>(int id) {
    return _store.box<T>().get(id);
  }
}

import 'package:path_provider/path_provider.dart';
import 'package:therapist_side/objectbox.g.dart';
import 'package:path/path.dart' as path;

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: path.join(docsDir.path, "mk"));
    return ObjectBox._create(store);
  }
}

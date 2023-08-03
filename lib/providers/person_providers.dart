import 'package:flutter/cupertino.dart';
import 'package:therapist_side/main.dart';
import 'package:therapist_side/models/person_model.dart';

class PersonProvider extends ChangeNotifier {
  static late List<PersonModel> personLists;

  Future<void> updateAllCallHistoryItems() async {
    personLists = database.getAllItems<PersonModel>();
  }

  Future<void> addItemToList(PersonModel item) async {
    database.putItem<PersonModel>(item);
  }

  Future<void> deleteItem(int id) async {
    database.removeItem<PersonModel>(id);
  }

  Future<PersonModel?> getPerson(int id) async {
    return Future.value(database.getItem<PersonModel>(id));
  }
}

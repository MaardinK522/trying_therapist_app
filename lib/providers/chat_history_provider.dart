import 'package:flutter/cupertino.dart';
import 'package:therapist_side/main.dart';
import 'package:therapist_side/models/person_model.dart';

import '../models/chat_history_item_model.dart';

class ChatHistoryProvider extends ChangeNotifier {
  static late List<ChatHistoryItemModel> chatHistoryItems;

  Future<void> updateAllChatHistoryItems() async {
    chatHistoryItems = database.getAllItems<ChatHistoryItemModel>();
    notifyListeners();
  }

  Future<void> addItemToList(ChatHistoryItemModel item, context) async {
    database.putItem<ChatHistoryItemModel>(item);
    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    database.removeItem<ChatHistoryItemModel>(id);
    notifyListeners();
  }

  List<PersonModel> doesExists(String name) =>
      database.doesChatHistoryItemExists(name);
}

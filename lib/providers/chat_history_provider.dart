import 'package:flutter/cupertino.dart';
import 'package:therapist_side/main.dart';

import '../models/chat_history_item_model.dart';

class ChatHistoryProvider extends ChangeNotifier {
  static late List<ChatHistoryItemModel> chatHistoryItems;

  Future<void> updateAllChatHistoryItems() async {
    chatHistoryItems = database.getAllItems<ChatHistoryItemModel>();
  }

  Future<void> addItemToList(ChatHistoryItemModel item) async {
    database.putItem<ChatHistoryItemModel>(item);
  }

  Future<void> deleteItem(int id) async {
    database.removeItem<ChatHistoryItemModel>(id);
  }
}

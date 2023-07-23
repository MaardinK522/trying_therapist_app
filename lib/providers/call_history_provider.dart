import 'package:flutter/material.dart';
import 'package:therapist_side/main.dart';
import '../models/call_history_item_model.dart';

class CallHistoryItemProvider extends ChangeNotifier {
  static late List<CallHistoryItemModel> callHistoryItems;

  Future<void> updateAllCallHistoryItems() async {
    callHistoryItems = database.getAllItems<CallHistoryItemModel>();
  }

  Future<void> addItemToList(CallHistoryItemModel item) async {
    database.putItem<CallHistoryItemModel>(item);
  }

  Future<void> deleteItem(int id) async {
    database.removeItem<CallHistoryItemModel>(id);
  }
}

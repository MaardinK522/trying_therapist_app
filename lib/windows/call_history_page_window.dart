import 'package:flutter/material.dart';
import '../listview_items/call_history_listview_item.dart';

class CallHistoryPageRoute extends StatefulWidget {
  const CallHistoryPageRoute({Key? key}) : super(key: key);

  @override
  State<CallHistoryPageRoute> createState() => _CallHistoryPageRouteState();
}

class _CallHistoryPageRouteState extends State<CallHistoryPageRoute> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CallHistoryListviewItem(
            index: index ~/ 2,
          ),
        ),
        itemCount: 5,
      ),
    );
  }
}

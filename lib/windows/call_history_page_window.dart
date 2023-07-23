import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_side/providers/call_history_provider.dart';
import '../listview_items/call_history_listview_item.dart';
import '../models/call_history_item_model.dart';

class CallHistoryPageRoute extends StatefulWidget {
  const CallHistoryPageRoute({Key? key}) : super(key: key);

  @override
  State<CallHistoryPageRoute> createState() => _CallHistoryPageRouteState();
}

class _CallHistoryPageRouteState extends State<CallHistoryPageRoute> {
  final _streamController = StreamController<List<CallHistoryItemModel>>();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      Duration(milliseconds: Random().nextInt(1000)),
      () => resetStream(),
    );
  }

  void resetStream() {
    Provider.of<CallHistoryItemProvider>(context, listen: false)
        .updateAllCallHistoryItems();
    _streamController.sink.add(CallHistoryItemProvider.callHistoryItems);
  }

  @override
  void dispose() {
    _streamController.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        var faker = Faker();
        var item = CallHistoryItemModel(
          personName: faker.person.name(),
          calledTime: faker.date.dateTime(),
        );
        Provider.of<CallHistoryItemProvider>(context, listen: false)
            .addItemToList(item);
        resetStream();
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<List<CallHistoryItemModel>>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return CallHistoryListItemView(
                    index: index,
                    item: snapshot.data![index],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
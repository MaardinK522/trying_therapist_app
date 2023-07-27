import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_side/models/chat_history_item_model.dart';
import 'package:therapist_side/providers/chat_history_provider.dart';
import '../list_item_views/chat_history_listitem_view.dart';

class ChatHistoryWindow extends StatefulWidget {
  const ChatHistoryWindow({Key? key}) : super(key: key);

  @override
  State<ChatHistoryWindow> createState() => ChatHistoryWindowState();

  static ChatHistoryWindowState? of(BuildContext context) =>
      context.findAncestorStateOfType<ChatHistoryWindowState>();
}

class ChatHistoryWindowState extends State<ChatHistoryWindow> with RouteAware {
  final _streamController = StreamController<List<ChatHistoryItemModel>>();
  late Timer timer;

  @override
  void initState() {
    debugPrint("Chat History");
    timer = Timer(const Duration(milliseconds: 100), () {
      updateItems();
    });
    super.initState();
  }

  @override
  void didPopNext() {
    updateItems();
    super.didPopNext();
  }
  @override
  void dispose() {
    timer.cancel();
    _streamController.close();
    super.dispose();
  }

  void updateItems() {
    Provider.of<ChatHistoryProvider>(context, listen: false)
        .updateAllChatHistoryItems();
    _streamController.sink.add(ChatHistoryProvider.chatHistoryItems);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Provider.of<ChatHistoryProvider>(context, listen: false)
            .updateAllChatHistoryItems();
        debugPrint(ChatHistoryProvider.chatHistoryItems.length.toString());
      },
      child: Scaffold(
        body: StreamBuilder<List<ChatHistoryItemModel>>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  return ChatPageRouteListviewItem(
                    patientImage: "assets/ghandi.jpeg",
                    index: index ~/ 2,
                    tagIndex: index,
                    item: ChatHistoryItemModel(
                      personName: snapshot.data![index].personName,
                      lastTextTime: snapshot.data![index].lastTextTime,
                      lastText: snapshot.data![index].lastText,
                      unReadText: Random().nextInt(10),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.grey,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.hasError.toString()),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

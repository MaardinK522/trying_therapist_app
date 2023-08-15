import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_side/models/chat_history_item_model.dart';
import 'package:therapist_side/providers/chat_history_provider.dart';

class ChatHistoryWindow extends StatefulWidget {
  const ChatHistoryWindow({Key? key}) : super(key: key);

  @override
  State<ChatHistoryWindow> createState() => ChatHistoryWindowState();

  static ChatHistoryWindowState? of(BuildContext context) => context.findAncestorStateOfType<ChatHistoryWindowState>();
}

class ChatHistoryWindowState extends State<ChatHistoryWindow> with RouteAware {
  final _streamController = StreamController<List<ChatHistoryItemModel>>();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 100), () {
      Provider.of<ChatHistoryProvider>(context, listen: false).updateAllChatHistoryItems();
      _streamController.sink.add(ChatHistoryProvider.chatHistoryItems);
    });
  }

  @override
  void didPopNext() {
    Provider.of<ChatHistoryProvider>(context, listen: false).updateAllChatHistoryItems();
    _streamController.sink.add(ChatHistoryProvider.chatHistoryItems);
    super.didPopNext();
  }

  @override
  void dispose() {
    timer.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // Provider.of<ChatHistoryProvider>(context, listen: false).updateAllChatHistoryItems();
      },
      child: const Scaffold(
          // body: Center(
          //   child: StreamBuilder<List<ChatHistoryItemModel>>(
          //     stream: _streamController.stream,
          //     builder: (BuildContext context, snapshot) {
          //       if (snapshot.hasData) {
          //         return ListView.builder(
          //           padding: const EdgeInsets.only(top: 20),
          //           itemCount: snapshot.data?.length,
          //           itemBuilder: (context, index) {
          //             return ChatPageRouteListItemView(
          //               patientImage: "assets/ghandi.jpeg",
          //               tagIndex: index,
          //               removeItem: () {
          //                 setState(() {
          //                   Provider.of<ChatHistoryProvider>(context, listen: false).deleteItem(snapshot.data![index].id);
          //                   snapshot.data?.removeAt(index);
          //                 });
          //               },
          //               item: snapshot.data![index],
          //             );
          //           },
          //           // separatorBuilder: (BuildContext context, int index) {
          //           //   return const Divider(
          //           //     height: 20,
          //           //     thickness: 1,
          //           //     color: Colors.grey,
          //           //   );
          //           // },
          //         );
          //       } else if (snapshot.hasError) {
          //         return Center(
          //           child: Text(snapshot.hasError.toString()),
          //         );
          //       }
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     },
          //   ),
          // ),
          ),
    );
  }
}

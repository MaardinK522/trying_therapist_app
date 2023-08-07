import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_side/main.dart';
import 'package:therapist_side/models/chat_history_item_model.dart';
import 'package:therapist_side/providers/chat_history_provider.dart';

import '../list_item_views/chat_history_list_view.dart';

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
  late final ChatHistoryProvider _chatHistoryProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
    _chatHistoryProvider =
        Provider.of<ChatHistoryProvider>(context, listen: false);
    timer = Timer(const Duration(milliseconds: 100), () {
      updateItems();
    });
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _chatHistoryProvider.updateAllChatHistoryItems();
      },
      child: Scaffold(
        body: StreamBuilder<List<ChatHistoryItemModel>>(
          stream: _streamController.stream,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  return ChatPageRouteListItemView(
                    patientImage: "assets/ghandi.jpeg",
                    tagIndex: index,
                    removeItem: () {
                      setState(() {
                        _chatHistoryProvider
                            .deleteItem(snapshot.data![index].id);
                        snapshot.data?.removeAt(index);
                      });
                    },
                    item: snapshot.data![index],
                  );
                },
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

  void updateItems() {
    _chatHistoryProvider.updateAllChatHistoryItems().whenComplete(() {
      if (!_streamController.isClosed) {
        _streamController.sink.add(ChatHistoryProvider.chatHistoryItems);
      }
    });
  }
}

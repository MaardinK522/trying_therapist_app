import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_side/models/chat_history_item_model.dart';
import 'package:therapist_side/providers/chat_history_provider.dart';
import 'package:therapist_side/routes/contact_picker_page_route.dart';
import 'package:therapist_side/transitions/custom_fade_transition.dart';
import '../listitem_views/chat_history_listitem_view.dart';

class ChatHistoryWindow extends StatefulWidget {
  const ChatHistoryWindow({Key? key}) : super(key: key);

  @override
  State<ChatHistoryWindow> createState() => _ChatHistoryWindowState();
}

class _ChatHistoryWindowState extends State<ChatHistoryWindow> {
  final _streamController = StreamController<List<ChatHistoryItemModel>>();

  @override
  void initState() {
    Provider.of<ChatHistoryProvider>(context, listen: false)
        .updateAllChatHistoryItems();
    _streamController.sink.add(ChatHistoryProvider.chatHistoryItems);
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    personName: "Mahatma Ghandhi",
                    lastTextTime: DateTime.now(),
                    lastText: "Jai mata dii",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CustomFadeTransition(page: const ContactPickerPageRoute()),
          );
        },
        child: const Icon(Icons.message_rounded),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:therapist_side/generated/assets.dart';
import 'package:therapist_side/models/chat_history_item_model.dart';

import '../routes/chat_page_route.dart';

class ChatPageRouteListItemView extends StatefulWidget {
  final String patientImage;
  final int tagIndex;
  final ChatHistoryItemModel item;
  final Function removeItem;

  const ChatPageRouteListItemView({
    Key? key,
    required this.patientImage,
    required this.item,
    required this.tagIndex,
    required this.removeItem,
  }) : super(key: key);

  @override
  State<ChatPageRouteListItemView> createState() =>
      _ChatPageRouteListItemViewState();
}

class _ChatPageRouteListItemViewState extends State<ChatPageRouteListItemView> {
  @override
  Widget build(BuildContext context) {
    int newMessageCount = Random().nextInt(10);
    return SizedBox(
      height: 60,
      child: InkWell(
        onTap: () {
          Navigator.push(
            this.context,
            MaterialPageRoute(
              builder: (context) => PatientChatPageRoute(
                index: widget.tagIndex,
                item: widget.item,
              ),
            ),
          );
        },
        onLongPress: () {
          widget.removeItem();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Hero(
                tag: "${widget.patientImage}${widget.tagIndex}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    Assets.assetsGhandi,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.personName,
                      style: const TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(widget.item.lastText),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${widget.item.lastTextTime?.hour}:${widget.item.lastTextTime?.minute}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  (newMessageCount <= 0)
                      ? const SizedBox(height: 10)
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${Random().nextInt(10)}",
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
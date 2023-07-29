import 'package:flutter/material.dart';
import 'package:therapist_side/generated/assets.dart';
import 'package:therapist_side/models/chat_history_item_model.dart';
import 'package:therapist_side/models/chat_message_model.dart';
import 'package:therapist_side/routes/patient_details_page_route.dart';

class PatientChatPageRoute extends StatefulWidget {
  final ChatHistoryItemModel item;
  final int index;

  const PatientChatPageRoute({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  State<PatientChatPageRoute> createState() => _PatientChatPageRouteState();
}

class _PatientChatPageRouteState extends State<PatientChatPageRoute> {
  List<ChatMessage> chatItems = [
    ChatMessage(
      time: DateTime.now(),
      message: "Jai mata dii",
      isSent: true,
    ),
    ChatMessage(
      time: DateTime.now(),
      message: "Hello",
    ),
  ];
  TextEditingController chatTextController = TextEditingController();
  late Color menuItemColor =
      (Theme.of(context).colorScheme.brightness == Brightness.dark)
          ? Colors.white
          : Colors.black;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: -5,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: "${Assets.assetsGhandi}${widget.index}",
                  child: ClipRect(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(Assets.assetsGhandi),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(widget.item.personName),
                ),
              ],
            ),
            actions: _buildAppbarActions(),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  reverse: true,
                  itemCount: chatItems.length,
                  itemBuilder: (context, index) {
                    var isSent = (chatItems[index].isSent);
                    return Row(
                      children: (isSent)
                          ? [
                              Card(
                                borderOnForeground: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    chatItems[index].message,
                                    textAlign: (isSent)
                                        ? TextAlign.left
                                        : TextAlign.right,
                                  ),
                                ),
                              ),
                              const Expanded(child: Center()),
                            ]
                          : [
                              const Expanded(child: Center()),
                              Card(
                                borderOnForeground: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    chatItems[index].message,
                                    textAlign: (isSent)
                                        ? TextAlign.left
                                        : TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: chatTextController,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onLongPress: () {
                              setState(() {
                                if (chatTextController.text.isNotEmpty) {
                                  chatItems.insert(
                                    0,
                                    ChatMessage(
                                      time: DateTime.now(),
                                      message: chatTextController.text,
                                      isSent: true,
                                    ),
                                  );
                                  chatTextController.clear();
                                }
                              });
                            },
                            child: IconButton(
                              onPressed: () {
                                if (chatTextController.text.isNotEmpty) {
                                  setState(() {
                                    chatItems.insert(
                                      0,
                                      ChatMessage(
                                        time: DateTime.now(),
                                        message: chatTextController.text,
                                      ),
                                    );
                                    chatTextController.clear();
                                  });
                                }
                              },
                              color: Theme.of(context).colorScheme.primary,
                              icon: const Icon(Icons.send),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          )),
    );
  }

  List<Widget> _buildAppbarActions() {
    return [
      PopupMenuButton(
        icon: const Icon(Icons.call),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "audio",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Voice call"),
                  Icon(
                    Icons.call,
                    color: menuItemColor,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: "Video chat",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Video"),
                  Icon(
                    Icons.video_call_rounded,
                    color: menuItemColor,
                  ),
                ],
              ),
            ),
          ];
        },
      ),
      PopupMenuButton<String>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onSelected: (String value) {
          if (value == "view") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientProfilePageRoute(
                  index: widget.index,
                  patientImage: Assets.assetsGhandi,
                  patientName: widget.item.personName,
                ),
              ),
            );
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "view",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("View profile"),
                  Icon(
                    Icons.person_rounded,
                    color: menuItemColor,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: "search",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Search"),
                  Icon(
                    Icons.search_rounded,
                    color: menuItemColor,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: "wallpapers",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Wallpapers"),
                  Icon(
                    Icons.wallpaper_rounded,
                    color: menuItemColor,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: "block",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Block"),
                  Icon(
                    Icons.block_outlined,
                    color: menuItemColor,
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    ].toList();
  }
}

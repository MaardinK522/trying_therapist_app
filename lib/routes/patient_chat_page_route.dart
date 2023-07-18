import 'dart:math';

import 'package:flutter/material.dart';
import 'package:therapist_side/routes/patient_profile_page_route.dart';

class PatientChatPageRoute extends StatefulWidget {
  final String patientName;
  final String patientImage;
  final int index;

  const PatientChatPageRoute(
      {super.key,
      required this.patientName,
      required this.index,
      required this.patientImage});

  @override
  State<PatientChatPageRoute> createState() => _PatientChatPageRouteState();
}

class _PatientChatPageRouteState extends State<PatientChatPageRoute> {
  var chatItems = ["Jai mata dii", "Hello"];
  TextEditingController chatTextController = TextEditingController();
  late var menuItemColor =
      (Theme.of(context).colorScheme.brightness == Brightness.dark)
          ? Colors.white
          : Colors.black;

  Widget chatItemView(index, isSent) => Card(
        borderOnForeground: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            chatItems[index],
            textAlign: (isSent) ? TextAlign.left : TextAlign.right,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: -5,
            title: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientProfilePageRoute(
                      index: widget.index,
                      patientImage: widget.patientImage,
                      patientName: widget.patientName,
                      jumpCode: "chat_code'",
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "${widget.patientImage}${widget.index}",
                    child: ClipRect(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(widget.patientImage),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(widget.patientName)),
                ],
              ),
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
                    bool isSent = Random().nextDouble() < 0.5;
                    return Row(
                      children: (isSent)
                          ? [
                              chatItemView(index, isSent),
                              const Expanded(child: Center()),
                            ]
                          : [
                              const Expanded(child: Center()),
                              Card(
                                borderOnForeground: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    chatItems[index],
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: chatTextController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: IconButton(
                        onPressed: () {},
                        color: Theme.of(context).colorScheme.primary,
                        icon: const Icon(Icons.send),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Call"),
                  Icon(
                    Icons.call,
                    color: menuItemColor,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Video call"),
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
      PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
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

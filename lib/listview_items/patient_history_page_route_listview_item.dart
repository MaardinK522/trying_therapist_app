import 'dart:math';

import 'package:flutter/material.dart';
import 'package:therapist_side/generated/assets.dart';

import '../routes/patient_chat_page_route.dart';

class ChatPageRouteListviewItem extends StatefulWidget {
  final String patientImage;
  final String patientName;
  final String lastText;
  final String lastTextDate;
  final AnimationController animationController;
  final int index;
  final int tagIndex;

  const ChatPageRouteListviewItem({
    Key? key,
    required this.patientImage,
    required this.patientName,
    required this.lastText,
    required this.lastTextDate,
    required this.animationController,
    required this.index,
    required this.tagIndex,
  }) : super(key: key);

  @override
  State<ChatPageRouteListviewItem> createState() =>
      _ChatPageRouteListviewItemState();
}

class _ChatPageRouteListviewItemState extends State<ChatPageRouteListviewItem> {
  @override
  Widget build(BuildContext context) {
    int newMessageCount = Random().nextInt(10);
    double animationStart = 0.1 * widget.index;
    double animationEnd = animationStart + 0.4;
    return SizedBox(
      height: 60,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, -1),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              animationStart,
              animationEnd,
              curve: Curves.easeIn,
            ),
          ),
        ),
        child: FadeTransition(
          opacity: widget.animationController,
          child: InkWell(
            onTap: () {
              Navigator.push(
                this.context,
                MaterialPageRoute(
                  builder: (context) => PatientChatPageRoute(
                    index: widget.tagIndex,
                    patientName: widget.patientName,
                    patientImage: widget.patientImage,
                  ),
                ),
              );
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
                          widget.patientName,
                          style: const TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(widget.lastText),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.lastTextDate,
                        style: const TextStyle(fontSize: 12),
                      ),
                      (newMessageCount <= 0)
                          ? const SizedBox(height: 10)
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.secondaryContainer,
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
        ),
      ),
    );
  }
}

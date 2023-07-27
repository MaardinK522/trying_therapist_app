import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:therapist_side/models/chat_history_item_model.dart';
import 'package:therapist_side/providers/chat_history_provider.dart';
import 'package:therapist_side/routes/patient_chat_page_route.dart';
import 'package:therapist_side/routes/patient_details_page_route.dart';
import 'package:therapist_side/transitions_effect/custom_fade_transition.dart';
import '../generated/assets.dart';

class AppointListItemView extends StatefulWidget {
  final String personName;
  final int index;
  final String personImage;
  final String personMessage;
  final Function onCanceled;

  const AppointListItemView({
    super.key,
    required this.personMessage,
    required this.onCanceled,
    required this.personName,
    required this.index,
    required this.personImage,
  });

  @override
  State<AppointListItemView> createState() => _AppointListItemViewState();
}

class _AppointListItemViewState extends State<AppointListItemView> {
  final indicatorTextStyle = const TextStyle(fontSize: 20);

  late ChatHistoryProvider provider =
      Provider.of<ChatHistoryProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      CustomFadeTransition(
                        page: PatientProfilePageRoute(
                          patientName: widget.personName,
                          patientImage: widget.personImage,
                          index: widget.index,
                          jumpCode: "chat_code",
                        ),
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.all(-10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Hero(
                      tag: "${widget.personImage}${widget.index}",
                      child: Image.asset(
                        Assets.assetsGhandi,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Hero(
                    tag: "${widget.personName}${widget.index}",
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        widget.personName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    widget.personMessage,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    onPressed: () {
                      ChatHistoryItemModel item = ChatHistoryItemModel(
                        personName: widget.personName,
                        lastTextTime: null,
                        lastText: '',
                        unReadText: 0,
                      );
                      bool foundOne = false;
                      for (var val in provider.doesExists(item.personName)) {
                        if (val.personName == item.personName) foundOne = true;
                      }
                      if (!foundOne) provider.addItemToList(item, context);
                      Navigator.push(
                        context,
                        CustomFadeTransition(
                          page: PatientChatPageRoute(
                            patientName: widget.personName,
                            index: 0,
                            patientImage: Assets.assetsGhandi,
                          ),
                        ),
                      );
                    },
                    child: const Text("Message"),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          onPressed: () {
                            widget.onCanceled();
                          },
                          child: const Text("CANCEL"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton.tonal(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          onPressed: () {
                            Fluttertoast.showToast(
                              msg: "Alpha builds does not support this feature",
                            );
                          },
                          child: const Text("Proceed"),
                        ),
                      ),
                    ],
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

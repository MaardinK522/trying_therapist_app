import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:therapist_side/models/chat_history_item_model.dart';
import 'package:therapist_side/providers/chat_history_provider.dart';
import 'package:therapist_side/routes/chat_page_route.dart';
import 'package:therapist_side/routes/patient_details_page_route.dart';
import 'package:therapist_side/transitions_effect/custom_fade_transition.dart';

import '../generated/assets.dart';

class AppointListItemView extends StatefulWidget {
  final int index;
  final Function onCanceled;
  final ChatHistoryItemModel item;
  final String personMessage;

  const AppointListItemView({
    super.key,
    required this.onCanceled,
    required this.index,
    required this.item,
    required this.personMessage,
  });

  @override
  State<AppointListItemView> createState() => _AppointListItemViewState();
}

class _AppointListItemViewState extends State<AppointListItemView> {
  final indicatorTextStyle = const TextStyle(fontSize: 20);

  late final ChatHistoryProvider _chatHistoryProvider =
      Provider.of<ChatHistoryProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var faker = Faker();
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          patientName: faker.person.name(),
                          patientImage: Assets.assetsGhandi,
                          index: widget.index,
                        ),
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.all(-10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Hero(
                      tag: "${Assets.assetsGhandi}${widget.index}",
                      child: Image.asset(
                        Assets.assetsGhandi,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Hero(
                    tag: "${faker.person.name()}${widget.index}",
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        faker.person.name(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    widget.item.lastText,
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
                        lastTextTime: DateTime.now(),
                        lastText: '',
                        unReadText: 0,
                        personID: -12,
                      );
                      bool foundOne = false;
                      for (var val in _chatHistoryProvider
                          .doesExists(faker.person.name())) {
                        if (val.personName == faker.person.name()) {
                          foundOne = true;
                        }
                      }
                      if (!foundOne) {
                        _chatHistoryProvider.addItemToList(item, context);
                      }
                      Navigator.push(
                        context,
                        CustomFadeTransition(
                          page: ChatPageRoute(
                            index: 0,
                            item: widget.item,
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

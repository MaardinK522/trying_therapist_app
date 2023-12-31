import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/medicine_course_item_model.dart';
import '../providers/medicine_listview_provider.dart';

class MedicineGroupBottomSheets extends StatefulWidget {
  final MedicineGroupItemModel item;

  const MedicineGroupBottomSheets({
    super.key,
    required this.item,
  });

  @override
  State<MedicineGroupBottomSheets> createState() =>
      _MedicineGroupBottomSheetsState();
}

class _MedicineGroupBottomSheetsState extends State<MedicineGroupBottomSheets> {
  final TextEditingController topicNameTextController = TextEditingController();
  final TextEditingController medicineNameTextController =
      TextEditingController();
  late List<String> medicineChipsList = List<String>.empty(growable: true);
  bool wasEmpty = false;

  @override
  void initState() {
    topicNameTextController.text = widget.item.topic;
    medicineChipsList.addAll(widget.item.medicines);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 50),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "ADD NEW SHORTCUT",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: topicNameTextController,
                    decoration: InputDecoration(
                      hintText: "Shortcut name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: medicineNameTextController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add_rounded),
                        onPressed: () {
                          if (medicineNameTextController.text.isNotEmpty) {
                            setState(() {
                              medicineChipsList.add(
                                medicineNameTextController.text.trim(),
                              );
                              medicineNameTextController.clear();
                              FocusScope.of(context).unfocus();
                            });
                          }
                        },
                      ),
                      hintText: "Medicine name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: medicineChipsList.map<Widget>(
                        (name) {
                          index++;
                          return ListTile(
                            leading: Text('$index'),
                            title: Text(name),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  medicineChipsList.remove(name);
                                });
                              },
                              icon: const Icon(Icons.delete_rounded),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Discard"),
                        Icon(Icons.close_rounded),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {
                      widget.item.topic = topicNameTextController.text.trim();
                      widget.item.medicines = medicineChipsList;
                      Provider.of<MedicineGroupListViewProvider>(context,
                              listen: false)
                          .addItemToList(
                        widget.item,
                      );
                      Navigator.pop(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.save),
                        Text("Save"),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

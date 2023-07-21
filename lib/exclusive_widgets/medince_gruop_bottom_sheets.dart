import 'package:flutter/material.dart';

import '../main.dart';
import '../models/medicine_course_listview_item_model.dart';

class MedicineGroupBottomSheets extends StatefulWidget {
  final List<String> medicineChipsList;
  final Function updateParent;
  final String topicName;

  const MedicineGroupBottomSheets({
    super.key,
    required this.medicineChipsList,
    required this.updateParent,
    required this.topicName,
  });

  @override
  State<MedicineGroupBottomSheets> createState() =>
      _MedicineGroupBottomSheetsState();
}

class _MedicineGroupBottomSheetsState extends State<MedicineGroupBottomSheets> {
  final TextEditingController topicNameTextController = TextEditingController();
  final TextEditingController medicineNameTextController =
      TextEditingController();

  @override
  void initState() {
    topicNameTextController.text = widget.topicName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                              var value =
                                  medicineNameTextController.text.trim();
                              widget.medicineChipsList.add(value);
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
                      children: widget.medicineChipsList
                          .map<Widget>(
                            (name) => ListTile(
                              title: Text(name),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.medicineChipsList.remove(name);
                                  });
                                },
                                icon: const Icon(Icons.delete_rounded),
                              ),
                            ),
                          )
                          .toList(),
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
                      if (topicNameTextController.text.isNotEmpty) {
                        database.putItem(
                          MedicineGroupListViewItemModel(
                            topic: topicNameTextController.text.trim(),
                            medicines: widget.medicineChipsList,
                          ),
                        );
                        Navigator.pop(context);
                        widget.updateParent();
                      }
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

import 'package:flutter/material.dart';

import '../main.dart';
import '../models/medicine_course_listview_item_model.dart';

class MedicineGroupBottomSheets extends StatefulWidget {
  const MedicineGroupBottomSheets({super.key});

  @override
  State<MedicineGroupBottomSheets> createState() =>
      _MedicineGroupBottomSheetsState();
}

class _MedicineGroupBottomSheetsState extends State<MedicineGroupBottomSheets> {
  final TextEditingController topicNameTextController = TextEditingController();
  final TextEditingController medicineNameTextController =
      TextEditingController();
  List<String> medicineChipsList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.73,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                      controller: topicNameTextController,
                      decoration: InputDecoration(
                        hintText: "Shortcut name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary),
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
                            setState(() {
                              medicineChipsList
                                  .add(medicineNameTextController.text.trim());
                            });
                          },
                        ),
                        hintText: "Medicine name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // TODO add chips views for medicine names
                    Wrap(
                      children: medicineChipsList
                          .map<Widget>(
                            (name) => Chip(label: Text(name)),
                          )
                          .toList(),
                    ),
                  ],
                ),
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
                      // TODO : Add item to database
                      if (topicNameTextController.text.isNotEmpty) {
                        database.putItem(
                          MedicineGroupListViewItemModel(
                            topic: topicNameTextController.text.trim(),
                            medicines: medicineChipsList,
                          ),
                        );
                        Navigator.pop(context);
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

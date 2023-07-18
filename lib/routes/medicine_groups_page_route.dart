import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import '../listview_items/medicine_group_listview_item.dart';
import '../models/medicine_course_listview_item_model.dart';

class MedicineCoursePageRoute extends StatefulWidget {
  const MedicineCoursePageRoute({Key? key}) : super(key: key);

  @override
  State<MedicineCoursePageRoute> createState() =>
      MedicineCoursePageRouteState();

  static MedicineCoursePageRouteState? of(BuildContext context) =>
      context.findAncestorStateOfType<MedicineCoursePageRouteState>();
}

class MedicineCoursePageRouteState extends State<MedicineCoursePageRoute> {
  final int itemCount = 5;
  late List<MedicineCourseListViewItemModel> items = getRandomItems(itemCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return MedicineGroupListviewItemView(
            onRemove: () {
              setState(() {
                items.removeAt(index);
              });
            },
            item: items[index],
            index: index,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            (Theme.of(context).colorScheme.brightness != Brightness.dark)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
        onPressed: () {
          setState(() {
            resetListItems();
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  void resetListItems() {
    setState(() {
      items = getRandomItems(itemCount);
    });
  }

  getRandomItems(int count) {
    return List<MedicineCourseListViewItemModel>.generate(
      count,
      (index) => MedicineCourseListViewItemModel(
        topic: "Common cold",
        isExpanded: false,
        medicines: List<String>.generate(
          Random.secure().nextInt(10),
          (index) => getRandString(10),
        ),
      ),
    );
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}

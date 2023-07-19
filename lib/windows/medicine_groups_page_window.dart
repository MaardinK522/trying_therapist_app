import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:therapist_side/main.dart';
import '../listview_items/medicine_group_listview_item.dart';
import '../models/medicine_course_listview_item_model.dart';

class MedicineCoursePageWindow extends StatefulWidget {
  const MedicineCoursePageWindow({Key? key}) : super(key: key);

  @override
  State<MedicineCoursePageWindow> createState() =>
      MedicineCoursePageWindowState();

  static MedicineCoursePageWindowState? of(BuildContext context) =>
      context.findAncestorStateOfType<MedicineCoursePageWindowState>();
}

class MedicineCoursePageWindowState extends State<MedicineCoursePageWindow> {
  final int itemCount = 5;

  // late List<MedicineGroupListViewItemModel> items = List.empty(
  //   growable: true,
  // );

  @override
  void initState() {
    super.initState();
    attachListItems();
  }

  void attachListItems() {
    var items = database.getAllItems();
    _streamController.sink.add(items);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  final _streamController =
      StreamController<List<MedicineGroupListViewItemModel>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<MedicineGroupListViewItemModel>>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return MedicineGroupListviewItemView(
                    onRemove: (id) {
                      setState(() {
                        database.removeItem(id);
                        snapshot.data?.removeAt(index);
                      });
                    },
                    item: snapshot.data![index],
                    index: index,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            (Theme.of(context).colorScheme.brightness != Brightness.dark)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
        onPressed: () {
          setState(() {
            database.putItem(
              MedicineGroupListViewItemModel(
                topic: 'Random topic',
                medicines: List.generate(Random.secure().nextInt(10),
                    (index) => getRandString(Random.secure().nextInt(10))),
              ),
            );
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}

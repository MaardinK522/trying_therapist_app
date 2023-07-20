import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:therapist_side/exclusive_widgets/medince_gruop_bottom_sheets.dart';
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
  final _streamController =
      StreamController<List<MedicineGroupListViewItemModel>>();

  @override
  void initState() {
    super.initState();
    attachListItems();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

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
          showBottomSheet(
            context: context,
            enableDrag: false,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            builder: (context) => const MedicineGroupBottomSheets(),
          );
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  void attachListItems() {
    var items = database.getAllItems();
    _streamController.sink.add(items);
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_side/providers/medicine_listview_provider.dart';
import '../exclusive_widgets/medicine_group_bottom_sheets.dart';
import '../listview_items/medicine_group_listview_item.dart';
import '../models/medicine_course_item_model.dart';

class MedicineCoursePageWindow extends StatefulWidget {
  const MedicineCoursePageWindow({Key? key}) : super(key: key);

  @override
  State<MedicineCoursePageWindow> createState() =>
      MedicineCoursePageWindowState();

  static MedicineCoursePageWindowState? of(BuildContext context) =>
      context.findAncestorStateOfType<MedicineCoursePageWindowState>();
}

class MedicineCoursePageWindowState extends State<MedicineCoursePageWindow> {
  final _streamController = StreamController<List<MedicineGroupItemModel>>();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      Duration(milliseconds: Random().nextInt(1000)),
      () => Provider.of<MedicineGroupListViewProvider>(context, listen: false)
          .updateAllMedicineGroupItems()
          .whenComplete(
            () => _streamController.sink.add(
              MedicineGroupListViewProvider.medicineGroupsItems,
            ),
          ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicineGroupListViewProvider>(
        builder: (BuildContext context, value, Widget? child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<List<MedicineGroupItemModel>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return MedicineGroupListviewItemView(
                      onRemove: (id) {
                        Provider.of<MedicineGroupListViewProvider>(context,
                                listen: false)
                            .deleteItem(id);
                        snapshot.data?.removeAt(index);
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
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              builder: (context) => MedicineGroupBottomSheets(
                item: MedicineGroupItemModel(
                  topic: '',
                  medicines: const <String>[].toList(growable: true),
                ),
              ),
            );
          },
          child: const Icon(Icons.add_rounded),
        ),
      );
    });
  }
}

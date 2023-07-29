import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exclusive_widgets/medicine_group_bottom_sheets.dart';
import '../list_item_views/medicine_group_list_item.dart';
import '../main.dart';
import '../models/medicine_course_item_model.dart';
import '../providers/medicine_listview_provider.dart';

class MedicineCoursePageWindow extends StatefulWidget {
  const MedicineCoursePageWindow({Key? key}) : super(key: key);

  @override
  State<MedicineCoursePageWindow> createState() =>
      MedicineCoursePageWindowState();

  static MedicineCoursePageWindowState? of(BuildContext context) =>
      context.findAncestorStateOfType<MedicineCoursePageWindowState>();
}

class MedicineCoursePageWindowState extends State<MedicineCoursePageWindow>
    with RouteAware {
  final _streamController = StreamController<List<MedicineGroupItemModel>>();
  late Timer timer;
  late final MedicineGroupListViewProvider _medicineGroupProvider =
      Provider.of<MedicineGroupListViewProvider>(context, listen: false);

  @override
  void didPopNext() {
    updateUI();

    super.didPopNext();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
    timer = Timer(
      Duration(milliseconds: Random().nextInt(1000)),
      () => updateUI(),
    );
  }

  void updateUI() {
    _medicineGroupProvider.updateAllMedicineGroupItems().whenComplete(
      () {
        setState(() {
          if (!_streamController.isClosed) {
            _streamController.sink.add(
              MedicineGroupListViewProvider.medicineGroupsItems,
            );
          }
        });
      },
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
                        _medicineGroupProvider.deleteItem(id);
                        updateUI();
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
          backgroundColor: Theme.of(context).colorScheme.secondary,
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

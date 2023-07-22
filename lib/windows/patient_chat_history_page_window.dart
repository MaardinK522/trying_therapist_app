import 'package:flutter/material.dart';
import '../listview_items/patient_history_page_route_listview_item.dart';

class PatientChatsHistoryPageWindow extends StatefulWidget {
  const PatientChatsHistoryPageWindow({Key? key}) : super(key: key);

  @override
  State<PatientChatsHistoryPageWindow> createState() =>
      _PatientChatsHistoryPageWindowState();
}

class _PatientChatsHistoryPageWindowState
    extends State<PatientChatsHistoryPageWindow> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 10),
      itemBuilder: (context, index) {
        return ChatPageRouteListviewItem(
          patientImage: "assets/ghandi.jpeg",
          patientName: "Mahatma Ghandhi",
          lastText: "Jai mata dii",
          lastTextDate: "25/03/1810",
          index: index ~/ 2,
          tagIndex: index,
        );
      },
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        );
      },
    );
  }
}

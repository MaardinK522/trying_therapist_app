import 'dart:async';

import 'package:flutter/material.dart';
import '../listview_items/patient_history_page_route_listview_item.dart';

class PatientChatsHistoryPageRoute extends StatefulWidget {
  const PatientChatsHistoryPageRoute({Key? key}) : super(key: key);

  @override
  State<PatientChatsHistoryPageRoute> createState() =>
      _PatientChatsHistoryPageRouteState();
}

class _PatientChatsHistoryPageRouteState
    extends State<PatientChatsHistoryPageRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Timer timer;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    Timer(
      const Duration(milliseconds: 300),
      () => animationController.forward(),
    );
    timer = Timer(
      const Duration(seconds: 2),
      () => setState(() {
        debugPrint("Called setState()");
      }),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    timer.cancel();
    super.dispose();
  }

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
          animationController: animationController,
          index: index ~/ 2,
          tagIndex: index,
        );
      },
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) {
        return FadeTransition(
          opacity: animationController,
          child: const Divider(
            height: 20,
            thickness: 1,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}

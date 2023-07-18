import 'dart:async';
import 'package:flutter/material.dart';
import '../listview_items/call_history_listview_item.dart';

class CallHistoryPageRoute extends StatefulWidget {
  const CallHistoryPageRoute({Key? key}) : super(key: key);

  @override
  State<CallHistoryPageRoute> createState() => _CallHistoryPageRouteState();
}

class _CallHistoryPageRouteState extends State<CallHistoryPageRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    Timer(
      const Duration(milliseconds: 300),
      () => _animationController.forward(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CallHistoryListviewItem(
            animationController: _animationController,
            index: index ~/ 2,
          ),
        ),
        itemCount: 5,
      ),
    );
  }
}

//   separatorBuilder: (context, index) {
//         double animationStart = 0.1 * index;
//         double animationEnd = animationStart + 0.4;
//         return SlideTransition(
//           position: Tween(
//             begin: const Offset(0, -1),
//             end: const Offset(0, 0),
//           ).animate(
//             CurvedAnimation(
//               parent: _animationController,
//               curve:
//                   Interval(animationStart, animationEnd, curve: Curves.easeIn),
//             ),
//           ),
//           child: FadeTransition(
//             opacity: _animationController,
//             child: Divider(
//               thickness: 2,
//               height: 5,
//               color: Theme.of(context).colorScheme.primary,
//             ),
//           ),
//         );
//       },

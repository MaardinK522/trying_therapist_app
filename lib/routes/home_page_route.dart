import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:therapist_side/transitions_effect/custom_fade_transition.dart';

import '../routes/scan_page_route.dart';
import '../routes/search_page_route.dart';
import '../routes/settings_route_page.dart';
import '../windows/call_history_window.dart';
import '../windows/chat_history_window.dart';
import '../windows/medicine_groups_window.dart';
import 'patient_appointments_page_route.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: _items.length,
    vsync: this,
    initialIndex: 1,
  );

  final _routes = const [
    MedicineCoursePageWindow(),
    ChatHistoryWindow(),
    CallHistoryPageRoute(),
  ];

  final TextEditingController searchTextFormFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint(DefaultTextStyle.of(context).style.fontFamily);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "TherapistSide",
          style: TextStyle(fontSize: 20),
        ),
        bottom: _tabBar,
        actions: _actions,
      ),
      body: TabBarView(
        controller: _tabController,
        children: _routes,
      ),
    );
  }

  late final _tabBar = TabBar(
    indicator: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadiusDirectional.circular(10),
    ),
    indicatorColor: Theme.of(context).colorScheme.primary,
    controller: _tabController,
    tabs: _items
        .map<Widget>(
          (item) => Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              item,
            ),
          ),
        )
        .toList(),
  );

  final _items = [
    Icons.medical_information_rounded,
    Icons.home,
    Icons.call_rounded,
  ];

  late final _actions = [
    IconButton(
      icon: const Icon(
        Icons.search_rounded,
      ),
      onPressed: () {
        Navigator.push(
          context,
          CustomFadeTransition(
            page: const SearchPageRoute(),
          ),
        );
      },
    ),
    badges.Badge(
      position: badges.BadgePosition.topEnd(top: 5, end: 5),
      showBadge: true,
      child: Center(
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              CustomFadeTransition(
                page: const PatientAppointmentsPageRoute(),
              ),
            );
          },
          icon: const Icon(Icons.calendar_month_rounded),
        ),
      ),
    ),
    PopupMenuButton(
      color: Theme.of(context).colorScheme.primaryContainer,
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) {
        if (value == "scan") {
          Navigator.push(
            context,
            CustomFadeTransition(
              page: const ScanPageRoute(),
            ),
          );
        }
        if (value == "notifications") {
          Fluttertoast.showToast(msg: "These feature is under development");
        }
        if (value == "settings") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsRoutePage(),
            ),
          );
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      itemBuilder: (context) {
        var menuItemColor =
            (Theme.of(context).colorScheme.brightness == Brightness.dark)
                ? Colors.white
                : Colors.black;
        return [
          PopupMenuItem(
            value: "scan",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.qr_code_scanner_rounded,
                  color: menuItemColor,
                ),
                const Text("SCAN QR")
              ],
            ),
          ),
          PopupMenuItem(
            value: "notifications",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.notifications_rounded,
                  color: menuItemColor,
                ),
                const Text("NOTIFICATIONS")
              ],
            ),
          ),
          PopupMenuItem(
            value: "settings",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.settings_rounded,
                  color: menuItemColor,
                ),
                const Text("SETTINGS")
              ],
            ),
          ),
        ];
      },
    )
  ].toList();
}

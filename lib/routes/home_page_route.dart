import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:fluttertoast/fluttertoast.dart';
import '../routes/call_history_page_route.dart';
import '../windows/medicine_groups_page_window.dart';
import '../windows/patient_chat_history_page_window.dart';
import '../routes/scan_page_route.dart';
import '../routes/search_page_route.dart';
import '../routes/settings_route_page.dart';
import '../transitions/custom_fade_transition.dart';
import 'patient_appointments_page_route.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: items.length,
    vsync: this,
    initialIndex: 1,
  );
  static const textStyle = TextStyle(fontSize: 15);
  static const items = [
    "CALLS",
    "PATIENTS",
    "MEDICINES",
  ];

  static const routes = [
    CallHistoryPageRoute(),
    PatientChatsHistoryPageWindow(),
    MedicineCoursePageWindow(),
  ];
  final TextEditingController searchTextFormFieldController =
      TextEditingController();
  late AppBar _appBar;

  @override
  Widget build(BuildContext context) {
    _appBar = AppBar(
      title: const Text("TherapistSide"),
      // shadowColor: Theme.of(context).colorScheme.primary,
      bottom: TabBar(
        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
        indicatorColor: Theme.of(context).colorScheme.primary,
        controller: _tabController,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: items
            .map<Widget>(
              (item) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(item, style: textStyle)),
            )
            .toList(),
      ),
      actions: _buildActions,
    );
    return Scaffold(
      appBar: _appBar,
      body: TabBarView(
        controller: _tabController,
        children: routes,
      ),
    );
  }

  get _buildActions => [
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
          ),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                CustomFadeTransition(
                  page: const SearchPageRoute(),
                ),
              );
            });
          },
        ),
        badges.Badge(
          position: badges.BadgePosition.topEnd(top: 5, end: 5),
          showBadge: true,
          child: Center(
            child: IconButton(
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "These feature is under development");
              },
              icon: const Icon(Icons.notifications_rounded),
            ),
          ),
        ),
        PopupMenuButton(
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
            if (value == "appointments") {
              Navigator.push(
                context,
                CustomFadeTransition(
                  page: const PatientAppointmentsPageRoute(),
                ),
              );
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
          color: Theme.of(context).colorScheme.secondaryContainer,
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
                value: "appointments",
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: menuItemColor,
                    ),
                    const Text("APPOINTMENTS")
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

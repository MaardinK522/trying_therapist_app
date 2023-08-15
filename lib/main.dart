import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:therapist_side/firebase_options.dart';
import 'package:therapist_side/providers/call_history_provider.dart';
import 'package:therapist_side/providers/chat_history_provider.dart';
import 'package:therapist_side/providers/medicine_listview_provider.dart';
import 'package:therapist_side/routes/signup_page_route.dart';

import 'utils/database.dart';

late Database database;
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await Database.create();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) => context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late String _fontFamily = "GoogleSans";

  Color _seedColor = Colors.green;
  ThemeMode _appThemeMode = ThemeMode.system;
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;

  get appThemeMode => _appThemeMode;

  get lightTheme => _lightTheme;

  get darkTheme => _darkTheme;

  get seedColor => _seedColor;

  get currentFontFamily => _fontFamily;

  setFontFamily(String fontFamily) {
    setState(() {
      _fontFamily = fontFamily;
    });
  }

  setSavedSeedColor() {
    SharedPreferences.getInstance().then(
      (pref) {
        switch (pref.getString("theme_color")) {
          case "orange":
            _seedColor = Colors.orange;
            break;
          case "pink":
            _seedColor = Colors.pink;
            break;
          case "red":
            _seedColor = Colors.red;
            break;
          case "blue":
            _seedColor = Colors.blue;
            break;
          case "green":
          default:
            _seedColor = Colors.green;
            break;
        }
      },
    );
    _darkTheme = ThemeData(
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.fromSeed(seedColor: _seedColor, brightness: Brightness.dark, background: _seedColor),
    );
    _lightTheme = ThemeData(
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ),
    );
  }

  setSavedThemeMode() {
    SharedPreferences.getInstance().then(
      (pref) {
        int mode = pref.getInt("theme_mode")!;
        if (mode < 0) {
          _appThemeMode = ThemeMode.dark;
        } else if (mode > 0) {
          _appThemeMode = ThemeMode.light;
        }
      },
    );
  }

  changeThemeMode(newThemeMode) {
    setState(() {
      _appThemeMode = newThemeMode;
      int themeCode = 0;
      if (newThemeMode == ThemeMode.dark) {
        themeCode = -1;
      } else if (newThemeMode == ThemeMode.light) {
        themeCode = 1;
      }
      saveThemeMode(themeCode);
    });
  }

  changeAppColorTheme(Color newSeedColor) {
    setState(
      () {
        _seedColor = newSeedColor;
        String color = "green";
        if (newSeedColor == Colors.red) {
          color = "red";
        } else if (newSeedColor == Colors.orange) {
          color = "orange";
        } else if (newSeedColor == Colors.pink) {
          color = "pink";
        } else if (newSeedColor == Colors.red) {
          color = "red";
        } else if (newSeedColor == Colors.blue) {
          color = "blue";
        }
        saveSeedColor(color);
      },
    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Timer(const Duration(seconds: 1), () {
      setState(() {
        setSavedSeedColor();
        setSavedThemeMode();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _reInitFirebase();
    }
  }

  @override
  Widget build(BuildContext context) {
    _lightTheme = ThemeData(
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ),
    );
    _darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ),
      fontFamily: _fontFamily,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MedicineGroupListViewProvider>(
          create: (_) => MedicineGroupListViewProvider(),
        ),
        ChangeNotifierProvider<CallHistoryItemProvider>(
          create: (_) => CallHistoryItemProvider(),
        ),
        ChangeNotifierProvider<ChatHistoryProvider>(
          create: (_) => ChatHistoryProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'TherapistSide',
        theme: _lightTheme,
        darkTheme: _darkTheme,
        themeMode: _appThemeMode,
        home: const SignupPageRoute(),
        navigatorObservers: [
          routeObserver,
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Future saveSeedColor(String color) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString("theme_color", color);
  }

  Future saveThemeMode(int mode) async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt("theme_mode", mode);
  }

  void _reInitFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

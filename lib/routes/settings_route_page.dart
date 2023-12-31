import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:therapist_side/routes/signup_page_route.dart';
import 'package:therapist_side/transitions_effect/custom_fade_transition.dart';
import 'package:therapist_side/utils/authentication.dart';

import '../main.dart';
import '../utils/theme_color.dart';

class SettingsRoutePage extends StatefulWidget {
  const SettingsRoutePage({Key? key}) : super(key: key);

  @override
  State<SettingsRoutePage> createState() => _SettingsRoutePageState();
}

class _SettingsRoutePageState extends State<SettingsRoutePage> {
  String _selected = "Light";
  var themeColors = [
    MyThemeColor(Colors.green, false),
    MyThemeColor(Colors.orange, false),
    MyThemeColor(Colors.pink, false),
    MyThemeColor(Colors.red, false),
    MyThemeColor(Colors.blue, false),
  ];
  final List<String> appFontFamilies = [
    "GoogleSans",
    "Arimo",
  ];

  var colorItemKey = GlobalKey<_SettingsRoutePageState>();

  @override
  void initState() {
    for (var item in themeColors) {
      if (item.color == MyApp.of(context)?.seedColor) item.isSelected = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MyApp.of(context)?.appThemeMode == ThemeMode.light) {
      _selected = "Light";
    } else if (MyApp.of(context)?.appThemeMode == ThemeMode.dark) {
      _selected = "Dark";
    } else if (MyApp.of(context)?.appThemeMode == ThemeMode.system) {
      _selected = "System";
    }
    appFontFamilies.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mahatma Ghandhi",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Toleration specialist",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              forceElevated: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Image.network(
                  FirebaseAuth.instance.currentUser!.photoURL!,
                  height: double.maxFinite,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top + 20),
                    ListTile(
                      onTap: () {},
                      leading: const Text("Edit profile"),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Text("Language"),
                      trailing: const Text(
                        "English",
                        style: TextStyle(fontWeight: FontWeight.w200),
                      ),
                    ),
                    ExpansionTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: const Text("Themes"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: const Text(
                                  "Light",
                                ),
                                trailing: Radio<String>(
                                  value: "Light",
                                  groupValue: _selected,
                                  onChanged: (value) {
                                    setState(() {
                                      _selected = value!;
                                    });
                                    MyApp.of(context)?.changeThemeMode(ThemeMode.light);
                                  },
                                ),
                              ),
                              ListTile(
                                titleAlignment: ListTileTitleAlignment.center,
                                title: const Text(
                                  "Dark",
                                ),
                                trailing: Radio<String>(
                                  value: "Dark",
                                  groupValue: _selected,
                                  onChanged: (value) {
                                    setState(() {
                                      _selected = value!;
                                    });
                                    MyApp.of(context)?.changeThemeMode(ThemeMode.dark);
                                  },
                                ),
                              ),
                              ListTile(
                                titleAlignment: ListTileTitleAlignment.center,
                                title: const Text(
                                  "System",
                                ),
                                trailing: Radio<String>(
                                  value: "System",
                                  groupValue: _selected,
                                  onChanged: (value) {
                                    setState(() {
                                      _selected = value!;
                                    });
                                    MyApp.of(context)?.changeThemeMode(ThemeMode.system);
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                key: colorItemKey,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: themeColors
                                    .map<Widget>(
                                      (themeColorItem) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            MyApp.of(context)?.changeAppColorTheme(themeColorItem.color);
                                            for (var element in themeColors) {
                                              element.isSelected = false;
                                            }
                                            themeColorItem.isSelected = true;
                                          });
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: themeColorItem.color,
                                            borderRadius: BorderRadius.circular(500),
                                            border: Border.all(
                                              color: ((MyApp.of(context)?.appThemeMode == ThemeMode.light)
                                                  ? MyApp.of(context)?.darkTheme.colorScheme.background
                                                  : MyApp.of(context)?.lightTheme.colorScheme.background) as Color,
                                              width: (themeColorItem.isSelected) ? 3 : 0,
                                            ),
                                          ),
                                          child: (themeColorItem.isSelected)
                                              ? const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: Icon(Icons.done_rounded),
                                                )
                                              : const Center(),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: appFontFamilies.map<Widget>(
                            (fontFamily) {
                              bool isSelected = false;
                              if (fontFamily == Theme.of(context).textTheme.bodyLarge!.fontFamily) isSelected = true;
                              return FilledButton.tonal(
                                onPressed: () {
                                  MyApp.of(context)!.setFontFamily(fontFamily);
                                },
                                style: ButtonStyle(
                                  textStyle: MaterialStatePropertyAll(
                                    TextStyle(
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: isSelected ? 2 : 0,
                                        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                child: Text(fontFamily),
                              );
                            },
                          ).toList(),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Authentication.signOut(context: context).then(
                  (value) {
                    Navigator.pushReplacement(
                      context,
                      CustomFadeTransition(page: const SignupPageRoute()),
                    );
                  },
                );
              },
              title: const Text("Logout"),
              trailing: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

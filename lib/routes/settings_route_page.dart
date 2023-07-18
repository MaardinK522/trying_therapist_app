import 'package:flutter/material.dart';
import '../generated/assets.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("TherapistSide"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        Assets.assetsGhandi,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Mahatma Ghandhi",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Toleration specialist",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(height: 10),
                  ListTile(
                    onTap: () {},
                    leading: const Text("Edit profile"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Text("Language"),
                    trailing: const Text("English"),
                  ),
                  ExpansionTile(
                    title: const Text("Themes"),
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            width: 4,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Theme"),
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
                                    MyApp.of(context)
                                        ?.changeThemeMode(ThemeMode.light);
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
                                    MyApp.of(context)
                                        ?.changeThemeMode(ThemeMode.dark);
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
                                    MyApp.of(context)
                                        ?.changeThemeMode(ThemeMode.system);
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: themeColors
                                    .map<Widget>(
                                      (themeColorItem) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            MyApp.of(context)
                                                ?.changeAppColorTheme(
                                                    themeColorItem.color);
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
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            border: Border.all(
                                              color: ((MyApp.of(context)
                                                          ?.appThemeMode ==
                                                      ThemeMode.light)
                                                  ? MyApp.of(context)
                                                      ?.darkTheme
                                                      .colorScheme
                                                      .background
                                                  : MyApp.of(context)
                                                      ?.lightTheme
                                                      .colorScheme
                                                      .background) as Color,
                                              width: (themeColorItem.isSelected)
                                                  ? 3
                                                  : 0,
                                            ),
                                          ),
                                          child: (themeColorItem.isSelected)
                                              ? const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      Icon(Icons.done_rounded),
                                                )
                                              : const Center(),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Theme.of(context).colorScheme.primaryContainer),
          ListTile(
            onTap: () {},
            title: const Text("Logout"),
            trailing: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    );
  }
}

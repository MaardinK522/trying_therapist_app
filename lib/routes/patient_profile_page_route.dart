import 'package:flutter/material.dart';

class PatientProfilePageRoute extends StatelessWidget {
  final String patientName;
  final String patientImage;
  final int index;
  final String jumpCode;
  final ScrollController scrollController = ScrollController();

  PatientProfilePageRoute(
      {super.key,
      required this.patientName,
      required this.patientImage,
      required this.index,
      required this.jumpCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      controller: scrollController,
      floatHeaderSlivers: false,
      headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            collapsedHeight: kToolbarHeight,
            expandedHeight: 360,
            floating: false,
            pinned: true,
            flexibleSpace: SingleChildScrollView(
              child: FlexibleSpaceBar(
                centerTitle: true,
                title: Column(
                  children: [
                    SizedBox(
                      height: kToolbarHeight * 2 +
                          MediaQuery.of(context).padding.top,
                    ),
                    Hero(
                      tag: "$patientImage$index$jumpCode",
                      child: Image.asset(
                        patientImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      patientName,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Text(
                      "Last seen 2years  ago",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight),
            const SizedBox(height: 50),
            ListTile(
              splashColor: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 5,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {},
              leading: const Icon(Icons.location_on_rounded),
              titleAlignment: ListTileTitleAlignment.center,
              title: const Center(
                child: Text("Show location"),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

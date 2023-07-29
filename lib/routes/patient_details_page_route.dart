import 'package:flutter/material.dart';

class PatientProfilePageRoute extends StatelessWidget {
  final String patientName;
  final String patientImage;
  final int index;
  final ScrollController scrollController = ScrollController();

  PatientProfilePageRoute({
    super.key,
    required this.patientName,
    required this.patientImage,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              expandedHeight: 200,
              collapsedHeight: kToolbarHeight,
              stretchTriggerOffset: 10,
              flexibleSpace: Hero(
                tag: "$patientImage$index",
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    patientImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Hero(
                tag: "$patientName$index",
                child: Material(
                  type: MaterialType.transparency,
                  child: Center(
                    child: Text(
                      patientName,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  "Last seen 2 years  ago",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

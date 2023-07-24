import 'package:flutter/material.dart';
import 'package:therapist_side/routes/patient_profile_page_route.dart';
import '../generated/assets.dart';
import '../transitions/custom_fade_transition.dart';

class PatientAppointListviewItem extends StatelessWidget {
  final String patientName;
  final int index;
  final String patientImage;
  final String patientMessage;
  final AnimationController animationController;
  final Function onCanceled;

  const PatientAppointListviewItem({
    super.key,
    required this.patientMessage,
    required this.animationController,
    required this.onCanceled,
    required this.patientName,
    required this.index,
    required this.patientImage,
  });

  final indicatorTextStyle = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Hero(
                          tag: "$patientImage$index${"chat_code"}",
                          child: Image.asset(
                            Assets.assetsGhandi,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const VerticalDivider(thickness: 2),
                      Expanded(
                        child: Text(
                          patientName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      patientMessage,
                      maxLines: 5,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonal(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        onPressed: () {
                          onCanceled();
                        },
                        child: const Text("CANCEL"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.tonal(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CustomFadeTransition(
                              page: PatientProfilePageRoute(
                                patientName: patientName,
                                patientImage: patientImage,
                                index: index,
                                jumpCode: "chat_code",
                              ),
                            ),
                          );
                        },
                        child: const Text("DETAILS"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

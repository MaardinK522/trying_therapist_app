import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:therapist_side/generated/assets.dart';

import '../listitem_views/patient_appointment_listview_item.dart';

class PatientAppointmentsPageRoute extends StatefulWidget {
  const PatientAppointmentsPageRoute({Key? key}) : super(key: key);

  @override
  State<PatientAppointmentsPageRoute> createState() =>
      _PatientAppointmentsPageRouteState();
}

class _PatientAppointmentsPageRouteState
    extends State<PatientAppointmentsPageRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late PageController appointmentsPageController;
  int appointmentCount = 3;

  @override
  void initState() {
    appointmentsPageController = PageController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    Timer(
      const Duration(milliseconds: 300),
      () => animationController.forward(),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    appointmentsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "Appointment count: ",
                    style: TextStyle(fontSize: 20),
                  )),
                  Text(
                    "$appointmentCount",
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: (appointmentCount < 1)
                  ? const Center(child: Text("No appointments for today"))
                  : PageView.builder(
                      itemCount: appointmentCount,
                      controller: appointmentsPageController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return PatientAppointListviewItem(
                          index: index,
                          patientName: "Mahatma Ghandhi",
                          patientImage: Assets.assetsGhandi,
                          patientMessage:
                              'I have headache from so many days did not shown to any doctor.',
                          animationController: animationController,
                          onCanceled: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Are you sure you?"),
                                content: const Text(
                                    "The patient will receive the cancellation notification. It may or may not affect your rating."),
                                actions: [
                                  FilledButton.tonal(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("NO"),
                                  ),
                                  FilledButton.tonal(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        appointmentCount--;
                                      });
                                    },
                                    child: const Text("YES"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (appointmentCount > 1) {
                        appointmentsPageController.previousPage(
                          curve: Curves.easeInQuad,
                          duration: const Duration(milliseconds: 500),
                        );
                      }
                    },
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                  ),
                  SmoothPageIndicator(
                    onDotClicked: (index) =>
                        appointmentsPageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    effect: ScaleEffect(
                      scale: 1.3,
                      dotColor: Colors.grey,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                    ),
                    controller: appointmentsPageController,
                    count: appointmentCount,
                  ),
                  IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      if (appointmentCount > 1) {
                        appointmentsPageController.nextPage(
                          curve: Curves.easeInQuad,
                          duration: const Duration(milliseconds: 500),
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:therapist_side/models/chat_history_item_model.dart';

import '../list_item_views/appointment_list_view.dart';

/// This route displays the
class PatientAppointmentsPageRoute extends StatefulWidget {
  const PatientAppointmentsPageRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<PatientAppointmentsPageRoute> createState() =>
      _PatientAppointmentsPageRouteState();
}

class _PatientAppointmentsPageRouteState
    extends State<PatientAppointmentsPageRoute> {
  PageController appointmentsPageController = PageController();
  int appointmentCount = Random().nextInt(10);

  @override
  void dispose() {
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
                    ),
                  ),
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
                        return AppointListItemView(
                          index: index,
                          item: ChatHistoryItemModel(
                            unReadText: 0,
                            lastText: 'Something',
                            lastTextTime: DateTime.now(),
                            personID: 0,
                          ),
                          personMessage:
                              'I have headache from so many days did not shown to any doctor.',
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

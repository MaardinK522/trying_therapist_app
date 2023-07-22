import 'package:flutter/material.dart';
import '../generated/assets.dart';

class CallPatientPageWindow extends StatefulWidget {
  final String patientName;

  const CallPatientPageWindow({
    Key? key,
    required this.patientName,
  }) : super(key: key);

  @override
  State<CallPatientPageWindow> createState() => _CallPatientPageWindowState();
}

class _CallPatientPageWindowState extends State<CallPatientPageWindow> {
  bool isMicOn = true;
  bool isSpeakerOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.patientName),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: Image.asset(
                  Assets.assetsGhandi,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 40),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
                  Text(
                    "Calling...",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(height: 200),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 4, color: Theme.of(context).colorScheme.primary),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isMicOn = !isMicOn;
                          });
                        },
                        icon: Icon((isMicOn)
                            ? Icons.mic_rounded
                            : Icons.mic_off_rounded),
                        iconSize: 40,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isSpeakerOn = !isSpeakerOn;
                          });
                        },
                        icon: Icon((isSpeakerOn)
                            ? Icons.volume_up_rounded
                            : Icons.volume_off_rounded),
                        iconSize: 40,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.error),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.call_end_rounded),
                            SizedBox(width: 10),
                            Text("End")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class CallHistoryListviewItem extends StatelessWidget {
  final AnimationController animationController;
  final int index;

  const CallHistoryListviewItem(
      {Key? key, required this.animationController, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double animationStart = 0.1 * index;
    double animationEnd = animationStart + 0.4;
    var faker = Faker();
    return SlideTransition(
      position: Tween(
        begin: const Offset(0, -1),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(animationStart, animationEnd, curve: Curves.easeIn),
        ),
      ),
      child: FadeTransition(
        opacity: animationController,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/ghandi.jpeg"),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      faker.person.name(),
                      style: const TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      faker.date.justTime(),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              FilledButton.tonal(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.call),
                    SizedBox(width: 10),
                    Text(
                      "Call",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

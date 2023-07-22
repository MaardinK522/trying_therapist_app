import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class CallHistoryListviewItem extends StatelessWidget {
  final int index;

  const CallHistoryListviewItem({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var faker = Faker();
    return Container(
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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
    );
  }
}

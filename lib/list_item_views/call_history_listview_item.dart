import 'package:flutter/material.dart';
import 'package:therapist_side/models/call_history_item_model.dart';

class CallHistoryListItemView extends StatelessWidget {
  final int index;
  final CallHistoryItemModel item;

  const CallHistoryListItemView({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  item.person.target!.personName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  "${item.calledTime.hour}:${item.calledTime.minute} "
                  "${item.calledTime.day}/${item.calledTime.month}",
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w100),
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
                Icon(
                  Icons.call,
                  size: 20,
                ),
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

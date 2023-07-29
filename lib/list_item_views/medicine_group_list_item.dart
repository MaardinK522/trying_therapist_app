import 'package:flutter/material.dart';
import 'package:therapist_side/exclusive_widgets/medicine_group_bottom_sheets.dart';
import 'package:therapist_side/main.dart';
import 'package:therapist_side/models/medicine_course_item_model.dart';

class MedicineGroupListviewItemView extends StatefulWidget {
  final int index;
  final MedicineGroupItemModel item;
  final Function onRemove;

  const MedicineGroupListviewItemView({
    Key? key,
    required this.item,
    required this.index,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<MedicineGroupListviewItemView> createState() =>
      _MedicineGroupListviewItemViewState();
}

class _MedicineGroupListviewItemViewState
    extends State<MedicineGroupListviewItemView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 2,
          color: (widget.item.isExpanded!)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      child: ExpansionTile(
        initiallyExpanded: widget.item.isExpanded!,
        tilePadding: const EdgeInsets.all(0),
        trailing: PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onSelected: (option) {
            if (option == "delete") widget.onRemove(widget.item.id);
            if (option == 'edit') _openBottomSheets();
          },
          itemBuilder: (BuildContext context) {
            var options = ["edit", "delete", "share"];
            return options.map<PopupMenuEntry<String>>((option) {
              var iconData = Icons.share_rounded;
              if (option == "edit") iconData = Icons.edit_rounded;
              if (option == "delete") iconData = Icons.delete_rounded;
              return PopupMenuItem(
                  value: option,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(option.toUpperCase()),
                      Icon(
                        iconData,
                        color: (Theme.of(context).colorScheme.brightness ==
                                Brightness.dark)
                            ? Colors.white
                            : Colors.black,
                      )
                    ],
                  ));
            }).toList();
          },
        ),
        subtitle: Row(
          children: [
            const SizedBox(width: 10),
            Text("Meds: ${widget.item.medicines.length}"),
          ],
        ),
        onExpansionChanged: (state) {
          setState(() {
            widget.item.isExpanded = state;
            database.putItem<MedicineGroupItemModel>(widget.item);
          });
        },
        childrenPadding: const EdgeInsets.all(10),
        title: Row(
          children: [
            const SizedBox(width: 10),
            Text(widget.item.topic),
          ],
        ),
        children: _buildItems(),
      ),
    );
  }

  _buildItems() {
    int index = 0;
    return widget.item.medicines.map<Widget>(
      (name) {
        index++;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('$index). $name'),
            const SizedBox(height: 10),
          ],
        );
      },
    ).toList();
  }

  void _openBottomSheets() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (context) => MedicineGroupBottomSheets(item: widget.item),
    );
  }
}

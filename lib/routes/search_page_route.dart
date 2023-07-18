import 'package:flutter/material.dart';

class SearchPageRoute extends StatefulWidget {
  const SearchPageRoute({Key? key}) : super(key: key);

  @override
  State<SearchPageRoute> createState() => _SearchPageRouteState();
}

class _SearchPageRouteState extends State<SearchPageRoute> {
  final TextEditingController searchTextFormFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: TextFormField(
            maxLines: 1,
            autofocus: true,
            textInputAction: TextInputAction.search,
            autocorrect: true,
            controller: searchTextFormFieldController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: (Theme.of(context).colorScheme.brightness ==
                          Brightness.dark)
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              hintStyle: const TextStyle(fontStyle: FontStyle.italic),
              hintText: "Search IDs, names...",
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

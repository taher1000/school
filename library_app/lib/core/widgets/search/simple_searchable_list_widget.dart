import 'package:flutter/material.dart';
import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/widgets/search/searchable_listview.dart';

import '../text/empty_widget.dart';

class SimpleSearchableList extends StatelessWidget {
  final Widget Function(List<dynamic>, int, dynamic)? builder;
  final void Function(dynamic) onItemSelected;
  final List items;
  final List<dynamic> Function(String)? filter;
  const SimpleSearchableList(
      {super.key,
      required this.builder,
      required this.onItemSelected,
      required this.items,
      this.filter});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return SearchableList(
      seperatorBuilder: (context, index) {
        return const Divider();
      },
      style: const TextStyle(fontSize: 12),
      builder: builder,
      errorWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(localize('error_occurred')),
        ],
      ),
      initialList: [],
      filter: filter,
      reverse: true,
      emptyWidget: const SizedBox(),
      onRefresh: () async {},
      onItemSelected: onItemSelected,
      inputDecoration: InputDecoration(
        labelText: localize("search"),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

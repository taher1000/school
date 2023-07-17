import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/assets_manager.dart';
import '../widgets/reading_card_list.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "Level Books",
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ReadingListItemCard(
                  image: ImageAssets.book1,
                  title: "Children Book",
                  auth: "Level: 2",
                  rating: 4.9,
                  pressDetails: () {},
                  pressRead: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

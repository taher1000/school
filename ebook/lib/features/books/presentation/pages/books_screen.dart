import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/features/books/presentation/widgets/book_levels_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/constants.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../bloc/books_bloc.dart';
import '../widgets/book_card_item.dart';

class BooksScreen extends StatefulWidget {
  final bool canPop;
  const BooksScreen({
    super.key,
    this.canPop = false,
  });

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  void initState() {
    BlocProvider.of<BooksBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      BlocProvider.of<BooksBloc>(context).add(FetchBooks());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "تصفح المحتوي",
      canPop: widget.canPop,
      body: Expanded(
        child: Column(
          children: [
            SizedBox(height: 50, child: const BookLevelList()),
            Expanded(
              child: PagedListView<int, Book>(
                pagingController:
                    BlocProvider.of<BooksBloc>(context).pagingController,
                builderDelegate: PagedChildBuilderDelegate<Book>(
                  itemBuilder: (context, item, index) => ListTile(
                    title: BookCardItem(catListKey: GlobalKey(), book: item),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

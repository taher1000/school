import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/features/books/presentation/widgets/book_card_item.dart';
import 'package:ebook/features/student_features/my_books/presentation/bloc/my_books_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';

class StudentMyBooksScreen extends StatefulWidget {
  const StudentMyBooksScreen({super.key});

  @override
  State<StudentMyBooksScreen> createState() => _StudentMyBooksScreenState();
}

class _StudentMyBooksScreenState extends State<StudentMyBooksScreen> {
  @override
  void initState() {
    BlocProvider.of<MyBooksBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      BlocProvider.of<MyBooksBloc>(context).add(FetchMyBooks());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canPop: false,
      screenTitle: AppLocalization.of(context).getTranslatedValues("my_books")!,
      body: Expanded(
        child: Column(
          children: [
            Expanded(
              child: PagedListView<int, Book>(
                pagingController:
                    BlocProvider.of<MyBooksBloc>(context).pagingController,
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

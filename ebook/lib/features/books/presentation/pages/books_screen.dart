import 'dart:async';

import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/widgets/loading/refresh_indicator.dart';
import 'package:ebook/features/books/presentation/pages/body_books_screen.dart';
import 'package:ebook/features/books/presentation/widgets/book_levels_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/constants.dart';
import '../../../../core/widgets/loading/list_shimmer_loading.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../core/widgets/text/empty_widget.dart';
import '../bloc/books_bloc.dart';
import '../widgets/book_card_item.dart';
import '../widgets/teacher_book_item.dart';

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
      if (pageKey > 1) {
        BlocProvider.of<BooksBloc>(context).add(FetchBooks());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        screenTitle: "تصفح المحتوي",
        canPop: widget.canPop,
        body: const BooksScreenBody());
  }
}

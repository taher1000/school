import 'package:ebook/core/constants.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/features/books/domain/entities/book.dart';
import 'package:ebook/features/books/presentation/bloc/books_bloc.dart';
import 'package:ebook/features/books/presentation/widgets/book_card_item.dart';
import 'package:ebook/features/books/presentation/widgets/books_pagination_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/widgets/loading/pagination_widget.dart';
import '../../../../core/widgets/loading/shimmer_loading.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/widgets/text/custom_error_widget.dart';
import '../../../../core/widgets/text/empty_widget.dart';

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
    BlocProvider.of<BooksBloc>(context).add(FetchBooks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "تصفح المحتوي",
      canPop: widget.canPop,
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.bookLevelImages.length,
              itemBuilder: (context, i) {
                return Image.asset(AppConstants.bookLevelImages[i],
                    width: 30, height: 30);
              },
            ),
          ),
          Expanded(
            child: BooksPaginationWidget<Book>(
              loadMore: () {
                BlocProvider.of<BooksBloc>(context).add(FetchBooks());
              },
              child: (Book book) {
                return BookCardItem(catListKey: GlobalKey(), book: book);
              },
            ),
          )
        ],
      ),
    );
  }
}

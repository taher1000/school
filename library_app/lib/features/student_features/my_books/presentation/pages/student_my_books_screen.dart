import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/enums/request_status.dart';
import '../../../../../core/widgets/loading/circular_progress_loader.dart';
import '../../../../../core/widgets/loading/refresh_indicator.dart';
import '../../../../../core/widgets/loading/show_books_request_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../../../books/presentation/widgets/book_card_item.dart';
import '../../../../books/presentation/widgets/book_levels_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../bloc/my_books_bloc.dart';

class StudentMyBooksScreen extends StatelessWidget {
  const StudentMyBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    return CustomScaffoldPagination(
      scrollController: _scrollController,
      title: "my_books",
      fetch: (bookLevel, isRefresh) => context
          .read<MyBooksBloc>()
          .add(FetchMyBooks(bookLevel: bookLevel, isRefresh: isRefresh)),
      builder: BlocBuilder<MyBooksBloc, MyBooksState>(
        builder: (context, state) {
          return ShowBooksRequestStatusWidget(
            books: state.books,
            errorMessage: state.errorMessage,
            hasReachedMax: state.hasReachedMax,
            scrollController: _scrollController,
            state: state.status,
          );
        },
      ),
    );
    // CustomScaffold(
    //     canPop: false,
    //     screenTitle:
    //         AppLocalization.of(context).getTranslatedValues("my_books"),
    //     body: MyRefreshIndicator(
    // onRefresh: () {
    //   final Completer<void> completer = Completer<void>();
    //   BlocProvider.of<MyBooksBloc>(context)
    //       .add(const FetchMyBooks(isRefresh: true));
    //   completer.complete();
    //   return completer.future;
    // },
    //       widget: Column(
    //         children: [
    //           SizedBox(
    //               height: 50.h,
    //               child: BookLevelList(
    // onLevelSelected: (level) {
    //   BlocProvider.of<MyBooksBloc>(context)
    //       .add(FetchMyBooks(bookLevel: level, isRefresh: true));
    //   bookLevel = level;
    // },
    //               )),
    // BlocBuilder<MyBooksBloc, MyBooksState>(
    //   builder: (context, state) {
    //     return ShowBooksRequestStatusWidget(
    //       books: state.books,
    //       errorMessage: state.errorMessage,
    //       hasReachedMax: state.hasReachedMax,
    //       scrollController: _scrollController,
    //       state: state.status,
    //     );
    //   },
    // ),
    //         ],
    //       ),
    //     )
    //     //const MyBooksBody()
    //     );
  }
}

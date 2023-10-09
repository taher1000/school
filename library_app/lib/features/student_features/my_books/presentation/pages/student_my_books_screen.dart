import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/enums/request_status.dart';
import '../../../../../core/widgets/loading/circular_progress_loader.dart';
import '../../../../../core/widgets/loading/refresh_indicator.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../../../books/presentation/widgets/book_card_item.dart';
import '../../../../books/presentation/widgets/book_levels_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../bloc/my_books_bloc.dart';

class StudentMyBooksScreen extends StatefulWidget {
  const StudentMyBooksScreen({super.key});

  @override
  State<StudentMyBooksScreen> createState() => _StudentMyBooksScreenState();
}

class _StudentMyBooksScreenState extends State<StudentMyBooksScreen> {
  final _scrollController = ScrollController();
  int? bookLevel;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyBooksBloc>(context).add(const FetchMyBooks());

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<MyBooksBloc>().add(FetchMyBooks(bookLevel: bookLevel));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        canPop: false,
        screenTitle:
            AppLocalization.of(context).getTranslatedValues("my_books"),
        body: MyRefreshIndicator(
          onRefresh: () {
            final Completer<void> completer = Completer<void>();
            // BlocProvider.of<MyBooksBloc>(context).isRefresh = true;

            BlocProvider.of<MyBooksBloc>(context)
                .add(const FetchMyBooks(isRefresh: true));
            completer.complete();
            return completer.future;
          },
          widget: Column(
            children: [
              SizedBox(
                  height: 50.h,
                  child: BookLevelList(
                    onLevelSelected: (level) {
                      BlocProvider.of<MyBooksBloc>(context)
                          .add(FetchMyBooks(bookLevel: level, isRefresh: true));
                      bookLevel = level;
                    },
                  )),
              BlocBuilder<MyBooksBloc, MyBooksState>(
                builder: (context, state) {
                  switch (state.status) {
                    case RequestStatus.loading:
                      return const CustomLoader();
                    case RequestStatus.error:
                      return EmptyWidget(
                        text: state.errorMessage,
                      );

                    case RequestStatus.success:
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.hasReachedMax
                              ? state.books.length
                              : state.books.length + 1,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return index >= state.books.length
                                ? CustomLoader()
                                : BookCardItem(book: state.books[index]);
                          },
                        ),
                      );
                    default:
                      return const CustomLoader();
                  }
                  // if (state is GetMyBooksLoading) {
                  //   return const ListShimmerLoadingWidget();
                  // }
                  // if (state is MyBooksLoaded) {
                  //   if (state.books!.data.isEmpty) {
                  //     return const EmptyWidget();
                  //   }
                  // }

                  // return Expanded(
                  //   child: PagedListView<int, Book>(
                  //     pagingController:
                  //         BlocProvider.of<MyBooksBloc>(context).pagingController,
                  //     builderDelegate: PagedChildBuilderDelegate<Book>(
                  //       itemBuilder: (context, item, index) =>
                  //           BookCardItem(book: item),
                  //     ),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        )
        //const MyBooksBody()
        );
  }
}

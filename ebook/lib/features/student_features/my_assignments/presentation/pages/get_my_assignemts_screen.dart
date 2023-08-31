import 'dart:async';

import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/core/widgets/loading/list_shimmer_loading.dart';
import 'package:ebook/core/widgets/loading/refresh_indicator.dart';
import 'package:ebook/features/books/presentation/widgets/book_levels_list.dart';
import 'package:ebook/features/student_features/my_assignments/presentation/bloc/my_assignments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../books/presentation/widgets/book_card_item.dart';

class StudentMyAssignmentsScreen extends StatefulWidget {
  final bool canPop;
  const StudentMyAssignmentsScreen({
    super.key,
    this.canPop = false,
  });

  @override
  State<StudentMyAssignmentsScreen> createState() =>
      _StudentMyAssignmentsScreenState();
}

class _StudentMyAssignmentsScreenState
    extends State<StudentMyAssignmentsScreen> {
  @override
  void initState() {
    BlocProvider.of<MyAssignmentsBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      BlocProvider.of<MyAssignmentsBloc>(context)
          .add(const FetchMyAssignments());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canPop: false,
      screenTitle:
          AppLocalization.of(context).getTranslatedValues("my_assignments")!,
      body: MyRefreshIndicator(
        onRefresh: () {
          final Completer<void> completer = Completer<void>();

          BlocProvider.of<MyAssignmentsBloc>(context)
              .add(const FetchMyAssignments());
          completer.complete();
          return completer.future;
        },
        widget: BlocConsumer<MyAssignmentsBloc, MyAssignmentsState>(
          listener: (context, state) {
            if (state is GetMyAssignmentsLoading) {
              context.loaderOverlay.show();
            }
            if (state is GetMyAssignmentsError) {
              context.loaderOverlay.hide();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is GetMyAssignmentsLoaded) {
              context.loaderOverlay.hide();
            }
          },
          builder: (context, state) {
            if (state is GetMyAssignmentsLoading) {
              return const ListShimmerLoadingWidget();
            }
            return Expanded(
              child: PagedListView<int, Book>(
                pagingController: BlocProvider.of<MyAssignmentsBloc>(context)
                    .pagingController,
                builderDelegate: PagedChildBuilderDelegate<Book>(
                  itemBuilder: (context, item, index) =>
                      BookCardItem(catListKey: GlobalKey(), book: item),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

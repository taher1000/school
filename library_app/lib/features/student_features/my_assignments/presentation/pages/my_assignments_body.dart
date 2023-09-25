import 'dart:async';

import 'package:library_app/core/entities/book/book.dart';
import 'package:library_app/core/widgets/loading/list_shimmer_loading.dart';
import 'package:library_app/core/widgets/loading/refresh_indicator.dart';
import 'package:library_app/features/student_features/my_assignments/presentation/bloc/my_assignments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/widgets/popup/custom_snack_bar.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../../../books/presentation/widgets/book_card_item.dart';

class MyAssignmentsBodyWidget extends StatelessWidget {
  const MyAssignmentsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MyAssignmentsBloc>(context).add(const FetchMyAssignments());
    return MyRefreshIndicator(
      onRefresh: () {
        final Completer<void> completer = Completer<void>();
        BlocProvider.of<MyAssignmentsBloc>(context).isRefresh = true;

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
            showSnackBar(context,
                message: state.message, backgroundColor: ColorManager.error);
          }
          if (state is GetMyAssignmentsLoaded) {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          if (state is GetMyAssignmentsLoading) {
            return const ListShimmerLoadingWidget();
          }
          if (state is GetMyAssignmentsLoaded) {
            if (state.books!.data.isEmpty) {
              return const EmptyWidget();
            }
          }
          return PagedListView<int, Book>(
            pagingController:
                BlocProvider.of<MyAssignmentsBloc>(context).pagingController,
            builderDelegate: PagedChildBuilderDelegate<Book>(
              itemBuilder: (context, item, index) =>
                  BookCardItem(book: item, isAssignment: true),
            ),
          );
        },
      ),
    );
  }
}

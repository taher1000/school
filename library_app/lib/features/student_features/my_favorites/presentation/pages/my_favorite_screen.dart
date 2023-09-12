import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:library_app/core/entities/book/book.dart';
import 'package:library_app/core/widgets/loading/list_shimmer_loading.dart';
import 'package:library_app/core/widgets/text/empty_widget.dart';
import 'package:library_app/features/books/presentation/widgets/book_card_item.dart';
import 'package:library_app/features/student_features/my_favorites/domain/entities/favorite_book.dart';
import 'package:library_app/features/student_features/my_favorites/presentation/bloc/my_favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/loading/refresh_indicator.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../books/presentation/widgets/book_levels_list.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  @override
  void initState() {
    BlocProvider.of<MyFavoritesBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      BlocProvider.of<MyFavoritesBloc>(context).add(const FetchMyFavorites());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canPop: false,
      screenTitle:
          AppLocalization.of(context).getTranslatedValues("my_favorites")!,
      body: MyRefreshIndicator(
        onRefresh: () {
          final Completer<void> completer = Completer<void>();

          BlocProvider.of<MyFavoritesBloc>(context)
              .add(const FetchMyFavorites());

          completer.complete();

          return completer.future;
        },
        widget: BlocConsumer<MyFavoritesBloc, MyFavoritesState>(
          listener: (context, state) {
            if (state is GetMyFavoritesLoading) {
              context.loaderOverlay.show();
            }
            if (state is GetMyFavoritesError) {
              context.loaderOverlay.hide();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is GetMyFavoritesLoaded) {
              context.loaderOverlay.hide();
            }
          },
          builder: (context, state) {
            if (state is GetMyFavoritesLoading) {
              return const ListShimmerLoadingWidget();
            }
            if (state is GetMyFavoritesLoaded) {
              if (state.favoriteBooks.data.isEmpty) {
                return const EmptyWidget();
              }
            }
            return Expanded(
                child: PagedListView<int, FavoriteBook>(
                    pagingController: BlocProvider.of<MyFavoritesBloc>(context)
                        .pagingController,
                    builderDelegate: PagedChildBuilderDelegate<FavoriteBook>(
                      itemBuilder: (context, item, index) =>
                          BookCardItem(book: item),
                    )));
          },
        ),
      ),
    );
  }
}

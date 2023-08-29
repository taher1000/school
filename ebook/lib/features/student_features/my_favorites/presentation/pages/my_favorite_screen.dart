import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/features/books/presentation/widgets/book_card_item.dart';
import 'package:ebook/features/student_features/my_favorites/domain/entities/favorite_book.dart';
import 'package:ebook/features/student_features/my_favorites/presentation/bloc/my_favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/resources/app_localization.dart';
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
      body: PagedListView<int, FavoriteBook>(
        pagingController:
            BlocProvider.of<MyFavoritesBloc>(context).pagingController,
        builderDelegate: PagedChildBuilderDelegate<FavoriteBook>(
          itemBuilder: (context, item, index) => ListTile(
            title: BookCardItem(catListKey: GlobalKey(), book: item),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // BlocProvider.of<MyFavoritesBloc>(context).pagingController.dispose();
    super.dispose();
  }
}

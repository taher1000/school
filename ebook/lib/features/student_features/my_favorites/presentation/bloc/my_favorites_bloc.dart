import 'package:bloc/bloc.dart';
import 'package:ebook/core/constants.dart';
import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/utils/utils.dart';
import 'package:ebook/features/books/domain/parameters/book_params.dart';
import 'package:ebook/features/student_features/my_books/domain/parameters/book_params.dart';
import 'package:ebook/features/student_features/my_favorites/data/models/favorite_book_summary_response.dart';
import 'package:ebook/features/student_features/my_favorites/domain/entities/favorite_book.dart';
import 'package:ebook/features/student_features/my_favorites/domain/usecases/favorite_book_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'my_favorites_event.dart';
part 'my_favorites_state.dart';

class MyFavoritesBloc extends Bloc<MyFavoritesEvent, MyFavoritesState> {
  final GetMyFavoriteBooksMyUseCase getUseCase;
  int pageKey = 1;
  final PagingController<int, FavoriteBook> pagingController =
      PagingController(firstPageKey: 0);

  MyFavoritesBloc(this.getUseCase) : super(MyFavoritesInitial()) {
    on<MyFavoritesEvent>((event, emit) async {
      if (event is FetchMyFavorites) {
        AppUtils().fetchPage(
            getUseCase: getUseCase,
            params: MyBookParams(
                pageNumber: pageKey,
                pageSize: AppConstants.pageSize,
                bookLevel: event.bookLevel),
            pagingController: pagingController,
            pageKey: pageKey);
        pageKey++;
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:library_app/core/constants.dart';
import 'package:library_app/core/entities/book/book.dart';
import 'package:library_app/core/params/pagination_params.dart';
import 'package:library_app/core/utils/utils.dart';
import 'package:library_app/features/books/domain/parameters/book_params.dart';
import 'package:library_app/features/student_features/my_books/domain/parameters/book_params.dart';
import 'package:library_app/features/student_features/my_favorites/data/models/favorite_book_summary_response.dart';
import 'package:library_app/features/student_features/my_favorites/domain/entities/favorite_book.dart';
import 'package:library_app/features/student_features/my_favorites/domain/usecases/favorite_book_use_case.dart';
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
        final params = PaginationParameters(
            pageNumber: pageKey, pageSize: AppConstants.pageSize);
        try {
          emit(GetMyFavoritesLoading());
          final newItems = await getUseCase.call(p: params);
          newItems.fold((l) => GetMyFavoritesError(message: l.message), (r) {
            final isLastPage = !r.nextPage!;
            if (isLastPage) {
              pagingController.value.itemList?.clear();
              pagingController.appendLastPage(r.data);
            } else {
              pagingController.appendPage(r.data, pageKey);
              pageKey++;
            }
            emit(GetMyFavoritesLoaded(favoriteBooks: r));
          });
        } catch (error) {
          pagingController.error = error;
        }
      }
    });
  }
}

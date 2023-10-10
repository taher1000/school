import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/utils/fetch_books_with_pagination.dart';
import '../../domain/entities/favorite_book.dart';
import '../../domain/usecases/favorite_book_use_case.dart';
import 'package:equatable/equatable.dart';

part 'my_favorites_event.dart';
part 'my_favorites_state.dart';

class MyFavoritesBloc extends Bloc<MyFavoritesEvent, MyFavoritesState> {
  final GetMyFavoriteBooksMyUseCase getUseCase;
  MyFavoritesBloc(this.getUseCase)
      : super(const MyFavoritesState(
          books: [],
          status: RequestStatus.loading,
          hasReachedMax: false,
          errorMessage: '',
        )) {
    int currentPageNumber = 0;

    final FetchBooksWithPagination fetchBoosWithPagination =
        FetchBooksWithPagination(useCase: getUseCase, state: state);

    on<MyFavoritesEvent>((event, emit) async {
      if (event is FetchMyFavorites) {
        if (event.isRefresh) {
          currentPageNumber = 1;
        } else {
          currentPageNumber = currentPageNumber + 1;
        }
        await fetchBoosWithPagination.getData(
          emit: emit,
          requestStatus: state.status,
          isRefresh: event.isRefresh,
          hasReachedMax: state.hasReachedMax,
          booksList: state.books,
          firstFetchParams: PaginationParameters(
            pageSize: AppConstants.pageSize,
            pageNumber: currentPageNumber,
          ),
          secondFetchParams: PaginationParameters(
            pageSize: AppConstants.pageSize,
            pageNumber: event.isRefresh ? 1 : currentPageNumber,
          ),
        );
      }
    }, transformer: droppable());
  }
}

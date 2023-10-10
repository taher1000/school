import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../core/constants.dart';
import '../../../../core/entities/book/book.dart';
import '../../../../core/enums/request_status.dart';
import '../../../../core/utils/fetch_books_with_pagination.dart';
import '../../../student_features/my_books/domain/parameters/book_params.dart';
import 'package:equatable/equatable.dart';
import '../../domain/parameters/book_params.dart';
import '../../domain/usecases/get_books_usecase.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooksUseCase getUseCase;
  BooksBloc(this.getUseCase)
      : super(const BooksState(
          books: [],
          status: RequestStatus.loading,
          hasReachedMax: false,
          errorMessage: '',
        )) {
    int currentPageNumber = 0;

    final FetchBooksWithPagination fetchBoosWithPagination =
        FetchBooksWithPagination(useCase: getUseCase, state: state);

    on<BooksEvent>((event, emit) async {
      if (event is FetchBooks) {
        if (event.isRefresh || event.bookLevel != null) {
          currentPageNumber = 1;
        } else {
          currentPageNumber = currentPageNumber + 1;
        }
        await fetchBoosWithPagination.getData(
          emit: emit,
          requestStatus: state.status,
          isRefresh: event.isRefresh,
          hasReachedMax: state.hasReachedMax,
          list: state.books,
          firstFetchParams: BookParams(
            pageSize: AppConstants.gridPageSize,
            pageNumber: currentPageNumber,
            bookLevel: event.bookLevel,
          ),
          secondFetchParams: BookParams(
            pageSize: event.bookLevel != null ? 20 : AppConstants.gridPageSize,
            pageNumber: event.isRefresh ? 1 : currentPageNumber,
            bookLevel: event.bookLevel,
          ),
        );
      }
    }, transformer: droppable());
  }
}

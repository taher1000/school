import 'package:bloc/bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/entities/book/book.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/utils/fetch_books_with_pagination.dart';
import '../../domain/parameters/book_params.dart';
import '../../domain/usecases/get_my_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'my_books_event.dart';
part 'my_books_state.dart';

class MyBooksBloc extends Bloc<MyBooksEvent, MyBooksState> {
  final GetMyBooksUseCase getUseCase;
  MyBooksBloc(this.getUseCase)
      : super(const MyBooksState(
          books: [],
          status: RequestStatus.loading,
          hasReachedMax: false,
          errorMessage: '',
        )) {
    int currentPageNumber = 0;

    final FetchBooksWithPagination fetchBoosWithPagination =
        FetchBooksWithPagination(useCase: getUseCase, state: state);

    on<MyBooksEvent>((event, emit) async {
      if (event is FetchMyBooks) {
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
          firstFetchParams: MyBookParams(
              pageSize: AppConstants.pageSize,
              pageNumber: currentPageNumber,
              bookLevel: event.bookLevel),
          secondFetchParams: MyBookParams(
              pageSize: AppConstants.pageSize,
              pageNumber: event.isRefresh ? 1 : currentPageNumber,
              bookLevel: event.bookLevel),
        );
      }
    }, transformer: droppable());
  }
}

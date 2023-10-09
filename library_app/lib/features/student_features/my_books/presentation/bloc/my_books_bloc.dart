import 'package:bloc/bloc.dart';
import 'package:library_app/features/books/domain/parameters/book_params.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/entities/book/book.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../../../../../core/utils/utils.dart';
import '../../domain/parameters/book_params.dart';
import '../../domain/usecases/get_my_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../../../core/models/book/response/book_summary_response.dart';

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
    int currentPageNumber = 1;
    on<MyBooksEvent>((event, emit) async {
      if (event is FetchMyBooks) {
        if (state.hasReachedMax && !event.isRefresh) return;
        if (state.status == RequestStatus.loading) {
          final books = await getUseCase(
              p: MyBookParams(
                  pageSize: AppConstants.pageSize,
                  pageNumber: currentPageNumber,
                  bookLevel: event.bookLevel));
          books.fold(
              (l) => emit(state.copyWith(
                  books: null,
                  status: RequestStatus.error,
                  hasReachedMax: false,
                  errorMessage: l.message)),
              (r) => emit(state.copyWith(
                  books: r.data,
                  status: RequestStatus.success,
                  hasReachedMax: r.nextPage == false,
                  errorMessage: '',
                  currentPageNumber: r.pageNumber)));
        } else {
          if (event.isRefresh) {
            currentPageNumber = 1;
          } else {
            currentPageNumber = currentPageNumber + 1;
          }

          final books = await getUseCase(
              p: MyBookParams(
                  pageSize: AppConstants.pageSize,
                  pageNumber: event.isRefresh ? 1 : currentPageNumber,
                  bookLevel: event.bookLevel));

          books.fold(
              (l) => emit(state.copyWith(
                  books: null,
                  status: RequestStatus.error,
                  hasReachedMax: false,
                  errorMessage: l.message)), (r) {
            if (event.isRefresh) {
              return emit(state.copyWith(
                  books: r.data,
                  status: RequestStatus.success,
                  hasReachedMax: r.nextPage == false,
                  errorMessage: ''));
            } else {
              return emit(state.copyWith(
                  books: List.of(state.books)..addAll(r.data),
                  status: RequestStatus.success,
                  hasReachedMax: r.nextPage == false,
                  errorMessage: ''));
            }
          });
        }
      }
    }, transformer: droppable());
  }
}

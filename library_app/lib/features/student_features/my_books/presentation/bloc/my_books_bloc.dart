import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:library_app/core/network/api_response_model.dart';
import 'package:library_app/features/books/domain/parameters/book_params.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/entities/book/book.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/params/pagination_params.dart';
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
    int currentPageNumber = 0;
    final FetchBoosWithPagination fetchBoosWithPagination =
        FetchBoosWithPagination();
    on<MyBooksEvent>((event, emit) async {
      if (event is FetchMyBooks) {
        if (event.isRefresh) {
          currentPageNumber = 1;
        } else {
          currentPageNumber = currentPageNumber + 1;
        }
        await fetchBoosWithPagination.getData(
          useCase: getUseCase,
          emit: emit,
          status: state.status,
          isRefresh: event.isRefresh,
          hasReachedMax: state.hasReachedMax,
          state: state,
          booksList: state.books,
          currentPageNumber: currentPageNumber,
          firstFetchParams: MyBookParams(
              pageSize: AppConstants.pageSize,
              pageNumber: currentPageNumber,
              bookLevel: event.bookLevel),
          params: MyBookParams(
              pageSize: AppConstants.pageSize,
              pageNumber: event.isRefresh ? 1 : currentPageNumber,
              bookLevel: event.bookLevel),
        );
      }
    }, transformer: droppable());
  }
}

class FetchBoosWithPagination {
  Future getData({
    required UseCase useCase,
    required bool isRefresh,
    required Emitter emit,
    required RequestStatus status,
    required bool hasReachedMax,
    required dynamic state,
    required List<Book> booksList,
    required int currentPageNumber,
    required PaginationParameters firstFetchParams,
    required PaginationParameters params,
  }) async {
    if (hasReachedMax && !isRefresh) return;
    if (status == RequestStatus.loading) {
      final Either<Failure, ApiResponse> books =
          await useCase.call(p: firstFetchParams);
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
      // if (isRefresh) {
      //   currentPageNumber = 1;
      // } else {
      //   currentPageNumber++;
      // }

      final Either<Failure, ApiResponse> books = await useCase.call(p: params);

      books.fold(
          (l) => emit(state.copyWith(
              books: null,
              status: RequestStatus.error,
              hasReachedMax: false,
              errorMessage: l.message)), (r) {
        if (isRefresh) {
          return emit(state.copyWith(
              books: r.data,
              status: RequestStatus.success,
              hasReachedMax: r.nextPage == false,
              errorMessage: ''));
        } else {
          return emit(state.copyWith(
              books: List.of(booksList)..addAll(r.data),
              status: RequestStatus.success,
              hasReachedMax: r.nextPage == false,
              errorMessage: ''));
        }
      });
    }
  }
}

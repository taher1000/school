import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/book/book.dart';
import '../enums/request_status.dart';
import '../network/api_response_model.dart';
import '../network/failure.dart';
import '../params/pagination_params.dart';
import '../uscecase/usecase.dart';

class FetchBooksWithPagination {
  final UseCase useCase;
  final dynamic state;

  FetchBooksWithPagination({required this.useCase, required this.state});
  Future getData({
    required bool isRefresh,
    required Emitter emit,
    required RequestStatus requestStatus,
    required bool hasReachedMax,
    required List<Book> booksList,
    required PaginationParameters firstFetchParams,
    required PaginationParameters secondFetchParams,
  }) async {
    if (hasReachedMax && !isRefresh) return;
    if (requestStatus == RequestStatus.loading) {
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
      final Either<Failure, ApiResponse> books =
          await useCase.call(p: secondFetchParams);

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
          // final booksList = state.books as List<Book>;
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

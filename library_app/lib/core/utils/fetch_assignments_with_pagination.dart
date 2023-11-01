import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enums/request_status.dart';
import '../network/api_response_model.dart';
import '../network/failure.dart';
import '../params/pagination_params.dart';
import 'fetch_data_with_pagination.dart';

class FetchAssignmentsWithPagination extends FetchDataWithPagination {
  FetchAssignmentsWithPagination(
      {required super.useCase, required super.state});
  @override
  Future<void> getData({
    required bool isRefresh,
    required Emitter emit,
    required RequestStatus requestStatus,
    required bool hasReachedMax,
    required List list,
    required PaginationParameters firstFetchParams,
    required PaginationParameters secondFetchParams,
  }) async {
    if (hasReachedMax && !isRefresh) return;
    if (requestStatus == RequestStatus.loading) {
      final Either<Failure, ApiResponse> books =
          await useCase.call(p: firstFetchParams);
      books.fold(
          (l) => emit(state.copyWith(
              assignments: null,
              status: RequestStatus.error,
              hasReachedMax: false,
              errorMessage: l.message)),
          (r) => emit(state.copyWith(
              assignments: r.data,
              status: RequestStatus.success,
              hasReachedMax: r.nextPage == false,
              errorMessage: '',
              currentPageNumber: r.pageNumber)));
    } else {
      final Either<Failure, ApiResponse> books =
          await useCase.call(p: secondFetchParams);

      books.fold(
          (l) => emit(state.copyWith(
              assignments: null,
              status: RequestStatus.error,
              hasReachedMax: false,
              errorMessage: l.message)), (r) {
        if (isRefresh) {
          return emit(state.copyWith(
              assignments: r.data,
              status: RequestStatus.success,
              hasReachedMax: r.nextPage == false,
              errorMessage: ''));
        } else {
          return emit(state.copyWith(
              assignments: List.of(list)..addAll(r.data),
              status: RequestStatus.success,
              hasReachedMax: r.nextPage == false,
              errorMessage: ''));
        }
      });
    }
  }
}

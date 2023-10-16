import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/params/pagination_params.dart';
import 'package:library_app/features/teacher_features/assignment_statistics/domain/params/assignment_statistics_params.dart';

import '../../../../../core/enums/request_status.dart';
import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/utils/fetch_data_with_pagination.dart';

class FetchAssignmentStatisticsWithPagination extends FetchDataWithPagination {
  FetchAssignmentStatisticsWithPagination(
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
              assignmentStatistics: null,
              status: RequestStatus.error,
              hasReachedMax: false,
              errorMessage: l.message)),
          (r) => emit(state.copyWith(
              assignmentStatistics: r.data,
              status: RequestStatus.success,
              hasReachedMax: r.nextPage == false,
              errorMessage: '',
              currentPageNumber: r.pageNumber)));
    } else {
      final Either<Failure, ApiResponse> books =
          await useCase.call(p: secondFetchParams);

      books.fold(
          (l) => emit(state.copyWith(
              assignmentStatistics: null,
              status: RequestStatus.error,
              hasReachedMax: false,
              errorMessage: l.message)), (r) {
        if (isRefresh) {
          return emit(state.copyWith(
              assignmentStatistics: r.data,
              status: RequestStatus.success,
              hasReachedMax: r.nextPage == false,
              errorMessage: ''));
        } else {
          return emit(state.copyWith(
              assignmentStatistics: List.of(list)..addAll(r.data),
              status: RequestStatus.success,
              hasReachedMax: r.nextPage == false,
              errorMessage: ''));
        }
      });
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/features/teacher_features/assignment/domain/entities/response/follow_up_student.dart';

import '../../../../../core/enums/request_status.dart';
import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/utils/fetch_data_with_pagination.dart';

class FetchFollowUpAssignmentsWithPagination extends FetchDataWithPagination {
  FetchFollowUpAssignmentsWithPagination(
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
    final assignmentsList = list as List<FollowUpStudent>;

    if (hasReachedMax && !isRefresh) return;
    if (requestStatus == RequestStatus.loading) {
      final Either<Failure, ApiResponse> assignments =
          await useCase.call(p: firstFetchParams);
      assignments.fold(
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
      final Either<Failure, ApiResponse> assignments =
          await useCase.call(p: secondFetchParams);
      assignments.fold(
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
              assignments: List.of(assignmentsList)..addAll(r.data),
              status: RequestStatus.success,
              hasReachedMax: r.nextPage == false,
              errorMessage: ''));
        }
      });
    }
  }
}

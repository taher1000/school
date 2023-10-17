import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/features/teacher_features/assignment_statistics/domain/entities/assignment_statistics.dart';

import '../../../../../core/enums/request_status.dart';
import '../../domain/params/assignment_statistics_params.dart';
import '../../domain/usecases/get_assignments_statistics_use_case.dart';
import '../logic/fetch_assignment_statistics_pagination.dart';

part 'assignment_statistics_event.dart';
part 'assignment_statistics_state.dart';

class AssignmentStatisticsBloc
    extends Bloc<AssignmentStatisticsEvent, AssignmentStatisticsState> {
  final GetAssignmentsStatisticsUseCase getUseCase;
  AssignmentStatisticsBloc(this.getUseCase)
      : super(const AssignmentStatisticsState(
          assignmentStatistics: [],
          status: RequestStatus.loading,
          hasReachedMax: false,
          errorMessage: '',
        )) {
    int currentPageNumber = 0;

    final FetchAssignmentStatisticsWithPagination fetchWithPagination =
        FetchAssignmentStatisticsWithPagination(
            useCase: getUseCase, state: state);

    on<AssignmentStatisticsEvent>((event, emit) async {
      if (event is FetchAssignmentStatisticsEvent) {
        currentPageNumber = currentPageNumber + 1;

        await fetchWithPagination.getData(
          emit: emit,
          requestStatus: state.status,
          isRefresh: false,
          hasReachedMax: state.hasReachedMax,
          list: state.assignmentStatistics,
          firstFetchParams: AssignmentStatisticsParams(
            pageSize: 300,
            pageNumber: currentPageNumber,
          ),
          secondFetchParams: AssignmentStatisticsParams(
            pageSize: 300,
            pageNumber: currentPageNumber,
          ),
        );
      }
    }, transformer: droppable());
  }
}

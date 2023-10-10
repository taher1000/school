import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../../core/entities/assignment/teacher_assignment.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/utils/fetch_assignments_with_pagination.dart';
import '../../domain/usecases/get_assignments_usecase.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final GetAssignmentsUseCase getUseCase;
  AssignmentBloc(this.getUseCase)
      : super(const AssignmentState(
          assignments: [],
          status: RequestStatus.loading,
          hasReachedMax: false,
          errorMessage: '',
        )) {
    int currentPageNumber = 0;

    final FetchAssignmentsWithPagination fetchAssignmentsWithPagination =
        FetchAssignmentsWithPagination(useCase: getUseCase, state: state);

    on<AssignmentEvent>((event, emit) async {
      if (event is FetchAssignments) {
        if (event.isRefresh) {
          currentPageNumber = 1;
        } else {
          currentPageNumber = currentPageNumber + 1;
        }
        await fetchAssignmentsWithPagination.getData(
          emit: emit,
          requestStatus: state.status,
          isRefresh: event.isRefresh,
          hasReachedMax: state.hasReachedMax,
          list: state.assignments,
          firstFetchParams: PaginationParameters(
            pageSize: AppConstants.listPageSize,
            pageNumber: currentPageNumber,
          ),
          secondFetchParams: PaginationParameters(
            pageSize: AppConstants.listPageSize,
            pageNumber: event.isRefresh ? 1 : currentPageNumber,
          ),
        );
      }
    }, transformer: droppable());
  }
}

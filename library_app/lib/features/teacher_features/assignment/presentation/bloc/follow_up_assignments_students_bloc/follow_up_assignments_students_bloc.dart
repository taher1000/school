import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/enums/request_status.dart';
import '../../../domain/entities/response/follow_up_student.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/params/pagination_params.dart';
import '../../../domain/usecases/get_all_follow_up_assignments_usecase.dart';
import '../../logic/fetch_follow_up_assignments_with_pagination.dart';

part 'follow_up_assignments_students_event.dart';
part 'follow_up_assignments_students_state.dart';

class FollowUpAssignmentsStudentsBloc extends Bloc<
    FollowUpAssignmentsStudentsEvent, FollowUpAssignmentsStudentsState> {
  final GetAllFollowUpAssignmentsUseCase getUseCase;
  FollowUpAssignmentsStudentsBloc(this.getUseCase)
      : super(const FollowUpAssignmentsStudentsState(
          assignments: [],
          status: RequestStatus.loading,
          hasReachedMax: false,
          errorMessage: '',
        )) {
    int currentPageNumber = 0;

    final FetchFollowUpAssignmentsWithPagination
        fetchAssignmentsWithPagination = FetchFollowUpAssignmentsWithPagination(
            useCase: getUseCase, state: state);

    on<FollowUpAssignmentsStudentsEvent>((event, emit) async {
      if (event is FetchFollowUpAssignments) {
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

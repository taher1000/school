import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/params/pagination_params.dart';
import '../../data/models/assignment_summary_response.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/usecases/get_assignments_usecase.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final GetAssignmentsUseCase getUseCase;

  AssignmentBloc(this.getUseCase) : super(AssignmentInitial()) {
    AssignmentSummaryResponsePage assignments = AssignmentSummaryResponsePage(
      data: [],
      pageNumber: 1,
      nextPage: false,
    );
    on<AssignmentEvent>((event, emit) async {
      if (event is FetchAssignments) {
        bool isInitial = assignments.pageNumber == 1;
        isInitial
            ? emit(GetAssignmentsLoading())
            : emit(GetAssignmentsLoaded(
                assignments: assignments,
                loading: LoadingMore(message: 'Fetching more products...')));
        final response = await getUseCase(
            p: PaginationParameters(
                pageNumber: assignments.pageNumber!, pageSize: 10));
        response.fold(
            (l) => isInitial
                ? emit(AssignmentInitial())
                : emit(GetAssignmentsLoaded(
                    assignments: assignments,
                    error: LoadMoreError(
                        message: 'Failed to load more assignments'))), (r) {
          if (isInitial) {
            assignments = r;

            if (assignments.data!.isEmpty) {
              emit(GetAssignmentsEmpty());
            }
          } else {
            //Adding BookSummaryResponsePage to existing list
            assignments = AssignmentSummaryResponsePage(
                data: assignments.data! + r.data!,
                pageNumber: r.pageNumber! + 1,
                nextPage: r.nextPage);
          }
          emit(GetAssignmentsLoaded(assignments: assignments));
        });
      }
    });
  }
}

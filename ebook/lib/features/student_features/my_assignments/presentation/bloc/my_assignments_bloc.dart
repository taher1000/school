import 'package:bloc/bloc.dart';
import 'package:ebook/core/models/assignment/student_assignment_summary_response.dart';
import 'package:ebook/features/student_features/my_assignments/domain/usecases/get_my_assignments_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/params/pagination_params.dart';

part 'my_assignments_event.dart';
part 'my_assignments_state.dart';

class MyAssignmentsBloc extends Bloc<MyAssignmentsEvent, MyAssignmentsState> {
  final GetStudentMyAssignmentsUseCase getUseCase;
  MyAssignmentsBloc(this.getUseCase) : super(MyAssignmentsInitial()) {
    StudentAssignmentSummaryResponsePage assignments =
        StudentAssignmentSummaryResponsePage(
      data: [],
      pageNumber: 1,
      nextPage: false,
    );
    on<MyAssignmentsEvent>((event, emit) async {
      if (event is FetchMyAssignments) {
        bool isInitial = assignments.pageNumber == 1;
        isInitial
            ? emit(GetMyAssignmentsLoading())
            : emit(GetMyAssignmentsLoaded(
                assignments: assignments,
                loading: LoadingMore(message: 'Fetching more products...')));
        final response = await getUseCase(
            p: PaginationParameters(
                pageNumber: assignments.pageNumber!, pageSize: 10));
        response.fold(
            (l) => isInitial
                ? emit(MyAssignmentsInitial())
                : emit(GetMyAssignmentsLoaded(
                    assignments: assignments,
                    error: LoadMoreError(
                        message: 'Failed to load more assignments'))), (r) {
          if (isInitial) {
            assignments = r;

            if (assignments.data!.isEmpty) {
              emit(GetMyAssignmentsEmpty());
            }
          } else {
            //Adding BookSummaryResponsePage to existing list
            assignments = StudentAssignmentSummaryResponsePage(
                data: assignments.data! + r.data!,
                pageNumber: r.pageNumber! + 1,
                nextPage: r.nextPage);
          }
          emit(GetMyAssignmentsLoaded(assignments: assignments));
        });
      }
    });
  }
}

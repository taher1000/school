import 'package:bloc/bloc.dart';
import '../../data/models/response/all_student_summary_response.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/params/pagination_params.dart';
import '../../domain/params/student_parameters.dart';
import '../../domain/usecase/get_all_students_usecase.dart';

part 'get_students_event.dart';
part 'get_students_state.dart';

class GetStudentsBloc extends Bloc<GetStudentsEvent, GetStudentsState> {
  final GetAllStudentsUseCase getAllStudentsUseCase;

  GetStudentsBloc(this.getAllStudentsUseCase) : super(GetAllStudentsInitial()) {
    AllStudentsSummaryResponsePage students = AllStudentsSummaryResponsePage(
      data: [],
      pageNumber: 1,
      nextPage: false,
    );
    on<GetStudentsEvent>((event, emit) async {
      if (event is FetchStudents) {
        bool isInitial = students.pageNumber == 1;
        isInitial
            ? emit(GetAllStudentsLoading())
            : emit(GetAllStudentsLoaded(
                students: students,
                loading: GetAllStudentsLoadingMore(
                    message: 'Fetching more Students...')));
        final response = await getAllStudentsUseCase(
            p: StudentParameters(
          pageNumber: students.pageNumber!,
          pageSize: 10,
          classYearID: event.classYearID,
          sectionID: event.sectionID,
        ));
        response.fold(
            (l) => isInitial
                ? emit(GetAllStudentsInitial())
                : emit(GetAllStudentsLoaded(
                    students: students,
                    error: GetAllStudentsLoadMoreError(
                        message: 'Failed to load more Students'))), (r) {
          if (isInitial) {
            students = r;

            if (students.data!.isEmpty) {
              emit(GetAllStudentsEmpty());
            }
          } else {
            //Adding StudentSummaryResponsePage to existing list
            students = AllStudentsSummaryResponsePage(
                data: students.data! + r.data!,
                pageNumber: r.pageNumber! + 1,
                nextPage: r.nextPage);
          }
          emit(GetAllStudentsLoaded(students: students));
        });
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../core/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/entities/student.dart';
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
    final PagingController<int, Student> pagingController =
        PagingController(firstPageKey: 0);
    on<GetStudentsEvent>((event, emit) async {
      if (event is FetchStudents) {
        if (event.sectionID != null) {
          pagingController.value = const PagingState(
            nextPageKey: 1,
            error: null,
            itemList: [],
          );
        }
        final params = StudentParameters(
            classYearID: event.classYearID,
            pageNumber: pagingController.nextPageKey!,
            pageSize: AppConstants.gridPageSize,
            sectionID: event.sectionID);
        emit(GetAllStudentsLoading());
        final newItems = await getAllStudentsUseCase(p: params);
        newItems.fold((l) => GetAllStudentsError(message: l.message), (r) {
          final isLastPage = !r.nextPage!;
          AppUtils().appendPage(
              pagingController: pagingController,
              isLastPage: isLastPage,
              data: r.data);

          emit(GetAllStudentsLoaded(students: r));
        });
      }
    });
  }
}

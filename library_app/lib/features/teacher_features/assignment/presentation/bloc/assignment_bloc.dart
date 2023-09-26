import 'package:bloc/bloc.dart';
import '../../../../../core/entities/assignment/teacher_assignment.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/models/assignment/teacher_assignment_summary_response.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/utils/utils.dart';
import '../../domain/usecases/get_assignments_usecase.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final GetAssignmentsUseCase getUseCase;
  int pageKey = 1;
  final PagingController<int, TeacherAssignment> pagingController =
      PagingController(firstPageKey: 1);
  bool isRefresh = false;
  AssignmentBloc(this.getUseCase) : super(AssignmentInitial()) {
    on<AssignmentEvent>((event, emit) async {
      if (isRefresh) {
        isRefresh = false;
        pagingController.refresh();
      }

      if (event is FetchAssignments) {
        final params = PaginationParameters(
          pageNumber: pagingController.nextPageKey!,
          pageSize: AppConstants.pageSize,
        );
        try {
          emit(GetAssignmentsLoading());
          final newItems = await getUseCase.call(p: params);
          newItems.fold((l) => GetAssignmentsError(message: l.message), (r) {
            final isLastPage = !r.nextPage!;
            AppUtils().appendPage(
                pagingController: pagingController,
                isLastPage: isLastPage,
                data: r.data);
            emit(GetAssignmentsLoaded(assignments: r));
          });
        } catch (error) {
          pagingController.error = error;
        }
      }
    });
  }
}

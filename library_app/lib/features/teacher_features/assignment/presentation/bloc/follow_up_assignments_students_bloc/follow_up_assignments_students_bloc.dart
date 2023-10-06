import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/models/response/follow_up_assignment_summary_response.dart';
import '../../../domain/entities/response/follow_up_student.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/params/pagination_params.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../domain/usecases/get_all_follow_up_assignments_usecase.dart';

part 'follow_up_assignments_students_event.dart';
part 'follow_up_assignments_students_state.dart';

class FollowUpAssignmentsStudentsBloc extends Bloc<
    FollowUpAssignmentsStudentsEvent, FollowUpAssignmentsStudentsState> {
  final GetAllFollowUpAssignmentsUseCase getUseCase;
  int pageKey = 1;
  final PagingController<int, FollowUpStudent> pagingController =
      PagingController(firstPageKey: 0);
  bool isRefresh = false;
  FollowUpAssignmentsStudentsBloc(this.getUseCase)
      : super(FollowUpAssignmentsStudentsInitial()) {
    on<FollowUpAssignmentsStudentsEvent>((event, emit) async {
      if (isRefresh) {
        isRefresh = false;
        pagingController.refresh();
      }

      if (event is FetchFollowUpAssignments) {
        final params = PaginationParameters(
          pageNumber: pagingController.nextPageKey!,
          pageSize: AppConstants.pageSize,
        );
        emit(GetFollowUpAssignmentsLoading());
        final newItems = await getUseCase.call(p: params);
        newItems.fold((l) => GetFollowUpAssignmentsError(message: l.message),
            (r) {
          final isLastPage = !r.nextPage!;
          AppUtils().appendPage(
              pagingController: pagingController,
              isLastPage: isLastPage,
              data: r.data);
          emit(GetFollowUpAssignmentsLoaded(followUpAssignments: r));
        });
      }
    });
  }
}

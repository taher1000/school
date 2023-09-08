import 'package:bloc/bloc.dart';
import 'package:library_app/core/entities/book/book.dart';
import 'package:library_app/core/models/assignment/student_assignment_summary_response.dart';
import 'package:library_app/features/student_features/my_assignments/domain/usecases/get_my_assignments_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/utils/utils.dart';
import '../../../my_books/domain/parameters/book_params.dart';

part 'my_assignments_event.dart';
part 'my_assignments_state.dart';

class MyAssignmentsBloc extends Bloc<MyAssignmentsEvent, MyAssignmentsState> {
  final GetStudentMyAssignmentsUseCase getUseCase;
  final PagingController<int, Book> pagingController =
      PagingController(firstPageKey: 1);
  bool isRefresh = false;
  MyAssignmentsBloc(this.getUseCase) : super(MyAssignmentsInitial()) {
    on<MyAssignmentsEvent>((event, emit) async {
      if (isRefresh) {
        isRefresh = false;
        pagingController.refresh();
      }
      if (event is FetchMyAssignments) {
        final params = MyBookParams(
            pageNumber: pagingController.nextPageKey!,
            pageSize: AppConstants.pageSize);
        emit(GetMyAssignmentsLoading());
        final newItems = await getUseCase.call(p: params);
        newItems.fold((l) => GetMyAssignmentsError(message: l.message), (r) {
          final isLastPage = !r.nextPage!;
          AppUtils().appendPage(
              pagingController: pagingController,
              bookLevel: null,
              isLastPage: isLastPage,
              data: r.data);
          emit(GetMyAssignmentsLoaded(r));
        });
      }
    });
  }
}

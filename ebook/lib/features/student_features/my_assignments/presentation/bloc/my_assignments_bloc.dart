import 'package:bloc/bloc.dart';
import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/models/assignment/student_assignment_summary_response.dart';
import 'package:ebook/features/student_features/my_assignments/domain/usecases/get_my_assignments_usecase.dart';
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
  int pageKey = 1;
  final PagingController<int, Book> pagingController =
      PagingController(firstPageKey: 0);

  MyAssignmentsBloc(this.getUseCase) : super(MyAssignmentsInitial()) {
    on<MyAssignmentsEvent>((event, emit) async {
      if (event is FetchMyAssignments) {
        final params =
            MyBookParams(pageNumber: pageKey, pageSize: AppConstants.pageSize);
        try {
          emit(GetMyAssignmentsLoading());
          final newItems = await getUseCase.call(p: params);
          newItems.fold((l) => GetMyAssignmentsError(message: l.message), (r) {
            final isLastPage = !r.nextPage!;
            if (isLastPage) {
              if (params.bookLevel != null) {
                pagingController.value = PagingState(
                  nextPageKey: null,
                  error: null,
                  itemList: r.data,
                );
              } else {
                pagingController.value.itemList?.clear();
                pagingController.appendLastPage(r.data);
              }
            } else {
              pagingController.appendPage(r.data, pageKey);
              pageKey++;
            }
            emit(GetMyAssignmentsLoaded(assignments: r));
          });
        } catch (e) {
          emit(GetMyAssignmentsError(message: e.toString()));
        }
      }
    });
  }
}

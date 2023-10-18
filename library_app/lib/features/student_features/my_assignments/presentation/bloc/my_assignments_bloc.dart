import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../../core/entities/assignment/student_assignment.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/utils/fetch_books_with_pagination.dart';
import '../../domain/usecases/get_my_assignments_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants.dart';
import '../../../my_books/domain/parameters/book_params.dart';

part 'my_assignments_event.dart';
part 'my_assignments_state.dart';

class MyAssignmentsBloc extends Bloc<MyAssignmentsEvent, MyAssignmentsState> {
  final GetStudentMyAssignmentsUseCase getUseCase;
  MyAssignmentsBloc(this.getUseCase)
      : super(const MyAssignmentsState(
          books: [],
          status: RequestStatus.loading,
          hasReachedMax: false,
          errorMessage: '',
        )) {
    int currentPageNumber = 0;

    final FetchBooksWithPagination fetchBoosWithPagination =
        FetchBooksWithPagination(
      useCase: getUseCase,
      state: state,
    );

    on<MyAssignmentsEvent>((event, emit) async {
      if (event is FetchMyAssignments) {
        if (event.isRefresh) {
          currentPageNumber = 1;
        } else {
          currentPageNumber = currentPageNumber + 1;
        }
        await fetchBoosWithPagination.getData(
          emit: emit,
          requestStatus: state.status,
          isRefresh: event.isRefresh,
          hasReachedMax: state.hasReachedMax,
          list: state.books,
          firstFetchParams: MyBookParams(
            pageSize: AppConstants.gridPageSize,
            pageNumber: currentPageNumber,
          ),
          secondFetchParams: MyBookParams(
            pageSize: AppConstants.gridPageSize,
            pageNumber: event.isRefresh ? 1 : currentPageNumber,
          ),
        );
      }
    }, transformer: droppable());
  }
}

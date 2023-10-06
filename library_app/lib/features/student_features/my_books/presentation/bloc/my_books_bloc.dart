import 'package:bloc/bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/entities/book/book.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../../../../../core/utils/utils.dart';
import '../../domain/parameters/book_params.dart';
import '../../domain/usecases/get_my_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/models/book/response/book_summary_response.dart';

part 'my_books_event.dart';
part 'my_books_state.dart';

class MyBooksBloc extends Bloc<MyBooksEvent, MyBooksState> {
  final GetMyBooksUseCase getUseCase;
  final PagingController<int, Book> pagingController =
      PagingController(firstPageKey: 0);
  bool isRefresh = false;

  MyBooksBloc(this.getUseCase) : super(MyBooksInitial()) {
    on<MyBooksEvent>((event, emit) async {
      if (isRefresh) {
        isRefresh = false;
        pagingController.refresh();
      }
      if (event is FetchMyBooks) {
        if (event.bookLevel != null) {
          pagingController.value = const PagingState(
            nextPageKey: 1,
            error: null,
            itemList: [],
          );
        }
        final params = MyBookParams(
            pageNumber: pagingController.nextPageKey!,
            pageSize: AppConstants.pageSize,
            bookLevel: event.bookLevel);
        emit(GetMyBooksLoading());
        final newItems = await getUseCase(p: params);
        newItems.fold((l) => GetMyBooksError(message: l.message), (r) {
          final isLastPage = !r.nextPage!;
          AppUtils().appendPage(
              pagingController: pagingController,
              isLastPage: isLastPage,
              data: r.data);

          emit(MyBooksLoaded(r));
        });
      }
    });
  }
}

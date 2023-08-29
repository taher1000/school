import 'package:bloc/bloc.dart';
import 'package:ebook/core/constants.dart';
import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/uscecase/usecase.dart';
import 'package:ebook/core/utils/utils.dart';
import 'package:ebook/features/student_features/my_books/domain/parameters/book_params.dart';
import 'package:ebook/features/student_features/my_books/domain/usecases/get_my_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/models/book/response/book_summary_response.dart';

part 'my_books_event.dart';
part 'my_books_state.dart';

class MyBooksBloc extends Bloc<MyBooksEvent, MyBooksState> {
  final GetMyBooksUseCase getUseCase;
  int pageKey = 1;
  final PagingController<int, Book> pagingController =
      PagingController(firstPageKey: 0);

  MyBooksBloc(this.getUseCase) : super(MyBooksInitial()) {
    on<MyBooksEvent>((event, emit) async {
      if (event is FetchMyBooks) {
        AppUtils().fetchPage(
            getUseCase: getUseCase,
            params: MyBookParams(
                pageNumber: pageKey,
                pageSize: AppConstants.pageSize,
                bookLevel: event.bookLevel),
            pagingController: pagingController,
            pageKey: pageKey);
        pageKey++;
      }
    });
  }
}

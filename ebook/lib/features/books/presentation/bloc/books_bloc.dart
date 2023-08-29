import 'package:bloc/bloc.dart';
import 'package:ebook/core/constants.dart';
import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/utils/utils.dart';
import 'package:ebook/features/books/domain/parameters/book_params.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../core/models/book/response/book_summary_response.dart';
import '../../domain/usecases/get_books_usecase.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooksUseCase getUseCase;

  int pageKey = 1;
  final PagingController<int, Book> pagingController =
      PagingController(firstPageKey: 0);

  BooksBloc(this.getUseCase) : super(BooksInitial()) {
    on<BooksEvent>((event, emit) async {
      if (event is FetchBooks) {
        AppUtils().fetchPage(
            getUseCase: getUseCase,
            params: BookParams(
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

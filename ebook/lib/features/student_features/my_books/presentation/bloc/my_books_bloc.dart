import 'package:bloc/bloc.dart';
import 'package:ebook/features/student_features/my_books/domain/parameters/book_params.dart';
import 'package:ebook/features/student_features/my_books/domain/usecases/get_my_books_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/models/book/response/book_summary_response.dart';

part 'my_books_event.dart';
part 'my_books_state.dart';

class MyBooksBloc extends Bloc<MyBooksEvent, MyBooksState> {
  final GetMyBooksUseCase getUseCase;

  MyBooksBloc(this.getUseCase) : super(MyBooksInitial()) {
    BookSummaryResponsePage books = BookSummaryResponsePage(
      data: [],
      pageNumber: 1,
      nextPage: false,
    );
    on<MyBooksEvent>((event, emit) async {
      if (event is FetchMyBooks) {
        bool isInitial = books.pageNumber == 1;
        isInitial
            ? emit(GetMyBooksLoading())
            : emit(GetMyBooksLoaded(
                books: books,
                loading: LoadingMore(message: 'Fetching more products...')));
        final response = await getUseCase(
            p: MyBookParams(
                pageNumber: books.pageNumber!,
                pageSize: 10,
                bookLevel: event.bookLevel));
        response.fold(
            (l) => isInitial
                ? emit(MyBooksInitial())
                : emit(GetMyBooksLoaded(
                    books: books,
                    error: LoadMoreError(
                        message: 'Failed to load more products'))), (r) {
          if (isInitial) {
            books = r;

            if (books.data!.isEmpty) {
              emit(GetMyBooksEmpty());
            }
          } else {
            //Adding BookSummaryResponsePage to existing list
            books = BookSummaryResponsePage(
                data: books.data! + r.data!,
                pageNumber: r.pageNumber! + 1,
                nextPage: r.nextPage);
          }
          emit(GetMyBooksLoaded(books: books));
        });
      }
    });
  }
}

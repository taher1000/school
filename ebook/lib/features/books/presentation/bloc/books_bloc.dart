import 'package:bloc/bloc.dart';
import 'package:ebook/core/constants.dart';
import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/utils/utils.dart';
import 'package:ebook/features/books/domain/parameters/book_params.dart';
import 'package:ebook/features/student_features/my_books/domain/parameters/book_params.dart';
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
        final params = BookParams(
            pageNumber: pageKey,
            pageSize: AppConstants.pageSize,
            bookLevel: event.bookLevel);
        try {
          emit(GetBooksLoading());
          final newItems = await getUseCase.call(p: params);
          newItems.fold((l) => GetBooksError(message: l.message), (r) {
            final isLastPage = !r.nextPage!;
            if (isLastPage) {
              if (params.bookLevel != null) {
                pagingController.value = PagingState(
                  nextPageKey: null,
                  error: null,
                  itemList: r.data,
                );
              } else {
                pagingController.appendLastPage(r.data);
              }
            } else {
              if (params.bookLevel != null) {
                pagingController.itemList = r.data;
              } else {
                pagingController.appendPage(r.data, pageKey);
                pageKey++;
              }
            }
            // return r;
          });
        } catch (e) {
          emit(GetBooksError(message: e.toString()));
        }
      }
    });
  }
}

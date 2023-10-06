import 'package:bloc/bloc.dart';
import '../../../../core/constants.dart';
import '../../../../core/entities/book/book.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/parameters/book_params.dart';
import '../../../student_features/my_books/domain/parameters/book_params.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../core/models/book/response/book_summary_response.dart';
import '../../domain/usecases/get_books_usecase.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooksUseCase getUseCase;
  bool isRefresh = false;
  final PagingController<int, Book> pagingController =
      PagingController(firstPageKey: 0);
  BooksBloc(this.getUseCase) : super(BooksInitial()) {
    on<BooksEvent>((event, emit) async {
      if (isRefresh) {
        isRefresh = false;
        pagingController.refresh();
      }
      if (event is FetchBooks) {
        if (event.bookLevel != null) {
          pagingController.value = const PagingState(
            nextPageKey: 1,
            error: null,
            itemList: [],
          );
        }
        final params = BookParams(
            pageNumber: pagingController.nextPageKey!,
            pageSize: AppConstants.pageSize,
            bookLevel: event.bookLevel);
        emit(GetBooksLoading());
        final newItems = await getUseCase(p: params);
        newItems.fold((l) => GetBooksError(message: l.message), (r) {
          final isLastPage = !r.nextPage!;
          AppUtils().appendPage(
              pagingController: pagingController,
              isLastPage: isLastPage,
              data: r.data);

          emit(GetBooksLoaded(books: r));
        });
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../teacher_features/assignment/domain/entities/request/book_collection_body.dart';

part 'book_selection_state.dart';

class BookSelectionCubit extends Cubit<BookSelectionState> {
  BookSelectionCubit() : super(BookSelectionInitial());
  final List<BookCollection> books = List.empty(growable: true);
  void addBook(BookCollection book) {
    state.books.removeWhere((element) => element.bookId == book.bookId);
    books.removeWhere((element) => element.bookId == book.bookId);
    // if (state.books.map((e) => e.bookId == book.bookId).isNotEmpty) {
    //        books.remove(book);
    // }
    state.books.add(book);
    emit(state.copyWith(
      books: state.books,
    ));
    books.add(book);
    emit(AddBookSelection(state.books));

    // if (!state.books.contains(book)) {
    //   state.books.add(book);
    //   emit(state.copyWith(
    //     books: state.books,
    //   ));
    //   books.add(book);
    //   emit(AddBookSelection(state.books));
    // }
  }

  void deleteBook(BookCollection book) {
    if (state.books.contains(book)) {
      state.books.remove(book);
      emit(state.copyWith(
        books: state.books,
      ));
      emit(AddBookSelection(state.books));
    }
  }
}

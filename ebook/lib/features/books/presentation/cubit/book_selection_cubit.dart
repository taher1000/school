import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/book/book.dart';

part 'book_selection_state.dart';

class BookSelectionCubit extends Cubit<BookSelectionState> {
  BookSelectionCubit() : super(BookSelectionInitial());

  void addBook(Book book) {
    if (!state.books.contains(book)) {
      state.books.add(book);
      emit(state.copyWith(
        books: state.books,
      ));
      emit(AddBookSelection(state.books));
    }
  }

  void deleteBook(Book book) {
    if (state.books.contains(book)) {
      state.books.remove(book);
      emit(state.copyWith(
        books: state.books,
      ));
      emit(AddBookSelection(state.books));
    }
  }
}

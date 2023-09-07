part of 'book_selection_cubit.dart';

class BookSelectionState extends Equatable {
  List<BookCollection> books = List.empty(growable: true);
  BookSelectionState(this.books);

  BookSelectionState copyWith({
    List<BookCollection>? books,
  }) {
    return BookSelectionState(
      books ?? this.books,
    );
  }

  @override
  List<Object> get props => [books];
}

final class BookSelectionInitial extends BookSelectionState {
  BookSelectionInitial() : super([]);
}

final class AddBookSelection extends BookSelectionState {
  AddBookSelection(List<BookCollection> books) : super(books);
}

final class DeleteBookSelection extends BookSelectionState {
  DeleteBookSelection(List<BookCollection> books) : super(books);
}

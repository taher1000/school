import 'package:bloc/bloc.dart';
import 'package:ebook/features/books/domain/parameters/book_params.dart';
import '../../../../core/params/pagination_params.dart';
import '../../data/models/book.dart';
import '../pages/books_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/response/book_summary_response.dart';
import '../../domain/entities/book.dart';
import '../../domain/usecases/get_books_usecase.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooksUseCase getUseCase;

  BooksBloc(this.getUseCase) : super(BooksInitial()) {
    BookSummaryResponsePage books = BookSummaryResponsePage(
      data: [],
      pageNumber: 1,
      nextPage: false,
    );
    on<BooksEvent>((event, emit) async {
      if (event is FetchBooks) {
        bool isInitial = books.pageNumber == 1;
        isInitial
            ? emit(GetBooksLoading())
            : emit(GetBooksLoaded(
                books: books,
                loading: LoadingMore(message: 'Fetching more products...')));
        final response = await getUseCase(
            p: BookParams(
                pageNumber: books.pageNumber!,
                pageSize: 10,
                bookLevel: event.bookLevel));
        response.fold(
            (l) => isInitial
                ? emit(BooksInitial())
                : emit(GetBooksLoaded(
                    books: books,
                    error: LoadMoreError(
                        message: 'Failed to load more products'))), (r) {
          if (isInitial) {
            books = r;

            if (books.data!.isEmpty) {
              emit(GetBooksEmpty());
            }
          } else {
            //Adding BookSummaryResponsePage to existing list
            books = BookSummaryResponsePage(
                data: books.data! + r.data!,
                pageNumber: r.pageNumber! + 1,
                nextPage: r.nextPage);
          }
          emit(GetBooksLoaded(books: books));
        });
      }
    });
  }
}

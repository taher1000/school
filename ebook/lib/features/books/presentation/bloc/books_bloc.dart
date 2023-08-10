import 'package:bloc/bloc.dart';
import 'package:ebook/core/params/pagination_params.dart';
import 'package:ebook/features/books/data/models/book.dart';
import 'package:ebook/features/books/presentation/pages/books_screen.dart';
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
      isLastPage: false,
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
            p: PaginationParameters(
                pageNumber: books.pageNumber, pageSize: 10));
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
                pageNumber: r.pageNumber + 1,
                isLastPage: r.isLastPage);
          }
          emit(GetBooksLoaded(books: books));
        });
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/book.dart';
import '../bloc/books_bloc.dart';
import 'book_card_item.dart';
import 'books_pagination_widget.dart';

class BooksItemsGridWidget extends StatefulWidget {
  const BooksItemsGridWidget({super.key});

  @override
  State<BooksItemsGridWidget> createState() => _BooksItemsGridWidgetState();
}

class _BooksItemsGridWidgetState extends State<BooksItemsGridWidget> {
  @override
  void initState() {
    BlocProvider.of<BooksBloc>(context).add(FetchBooks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BooksPaginationWidget<Book>(
        loadMore: () {
          BlocProvider.of<BooksBloc>(context).add(FetchBooks());
        },
        child: (Book book) {
          return BookCardItem(catListKey: GlobalKey(), book: book);
        },
      ),
    );
  }
}

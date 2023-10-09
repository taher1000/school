import 'package:flutter/material.dart';
import 'package:library_app/core/entities/book/book.dart';
import 'package:library_app/core/enums/request_status.dart';

import '../../../features/books/presentation/widgets/book_card_item.dart';
import '../text/empty_widget.dart';
import 'circular_progress_loader.dart';

class ShowBooksRequestStatusWidget extends StatelessWidget {
  final RequestStatus state;
  final String errorMessage;
  final bool hasReachedMax;
  final ScrollController scrollController;
  final List<Book> books;
  const ShowBooksRequestStatusWidget(
      {super.key,
      required this.state,
      required this.errorMessage,
      required this.hasReachedMax,
      required this.scrollController,
      required this.books});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case RequestStatus.loading:
        return const CustomLoader();
      case RequestStatus.error:
        return EmptyWidget(
          text: errorMessage,
        );

      case RequestStatus.success:
        return Expanded(
          child: ListView.builder(
            itemCount: hasReachedMax ? books.length : books.length + 1,
            controller: scrollController,
            itemBuilder: (context, index) {
              return index >= books.length
                  ? const CustomLoader()
                  : BookCardItem(book: books[index]);
            },
          ),
        );
      default:
        return const CustomLoader();
    }
  }
}

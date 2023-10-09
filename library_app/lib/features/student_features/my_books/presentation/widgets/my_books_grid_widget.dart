import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/request_status.dart';
import '../../../../../core/widgets/loading/circular_progress_loader.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../../../books/presentation/widgets/book_card_item.dart';
import '../bloc/my_books_bloc.dart';

class MyBooksListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const MyBooksListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBooksBloc, MyBooksState>(
      builder: (context, state) {
        switch (state.status) {
          case RequestStatus.loading:
            return const CustomLoader();
          case RequestStatus.error:
            return EmptyWidget(
              text: state.errorMessage,
            );

          case RequestStatus.success:
            return Expanded(
              child: ListView.builder(
                itemCount: state.hasReachedMax
                    ? state.books.length
                    : state.books.length + 1,
                controller: scrollController,
                itemBuilder: (context, index) {
                  return index >= state.books.length
                      ? const CustomLoader()
                      : BookCardItem(book: state.books[index]);
                },
              ),
            );
          default:
            return const CustomLoader();
        }
      },
    );
  }
}

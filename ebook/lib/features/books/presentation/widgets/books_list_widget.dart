import 'dart:convert';
import '../../../../core/entities/book/book.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../cubit/book_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/books_bloc.dart';
import 'basic_book_details_widget.dart';

class BooksItemsListWidget extends StatefulWidget {
  const BooksItemsListWidget({super.key});

  @override
  State<BooksItemsListWidget> createState() => _BooksItemsListWidgetState();
}

class _BooksItemsListWidgetState extends State<BooksItemsListWidget> {
  @override
  void initState() {
    BlocProvider.of<BooksBloc>(context).add(FetchBooks());
    super.initState();
  }

  bool showBookDetails = false;
  Book? book;
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          if (!showBookDetails)
            // Expanded(
            //   child: BooksPaginationWidget<Book>(
            //     isGrid: false,
            //     loadMore: () {
            //       BlocProvider.of<BooksBloc>(context).add(FetchBooks());
            //     },
            //     child: (Book book) {
            //       this.book = book;

            //       return BlocBuilder<BookSelectionCubit, BookSelectionState>(
            //           builder: (context, state) {
            //         return GestureDetector(
            //           onTap: () {
            //             if (state.books.contains(book)) {
            //               BlocProvider.of<BookSelectionCubit>(context)
            //                   .deleteBook(book);
            //             } else {
            //               BlocProvider.of<BookSelectionCubit>(context)
            //                   .addBook(book);
            //             }
            //           },
            //           onLongPress: () {
            //             BlocProvider.of<BookSelectionCubit>(context)
            //                 .addBook(book);
            //           },
            //           child: Card(
            //             child: ListTile(
            //                 leading: state.books.contains(book)
            //                     ? FaIcon(
            //                         FontAwesomeIcons.solidCircleCheck,
            //                         color: ColorManager.darkPrimary,
            //                       )
            //                     : FaIcon(
            //                         FontAwesomeIcons.circle,
            //                       ),
            //                 title: Text(
            //                   book.title!,
            //                   style: TextStyleManager.getBoldStyle(
            //                       color: ColorManager.darkGreyText,
            //                       fontSize: FontSize.s18),
            //                 ),
            //                 subtitle: Text(
            //                   book.authorName ?? "No AUTHOR NAME",
            //                   style: TextStyleManager.getMediumStyle(
            //                       color: ColorManager.darkGreyText),
            //                 ),
            //                 trailing: Image.memory(base64Decode(book.image!))),
            //           ),
            //         );
            //       });
            //     },
            //   ),
            // ),
            if (showBookDetails)
              SizedBox(height: 300, child: BasicBookDetailsWidget(book: book!))
        ],
      ),
    );
  }
}

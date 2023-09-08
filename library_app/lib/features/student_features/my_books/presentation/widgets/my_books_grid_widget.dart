// import 'package:library_app/features/student_features/my_books/presentation/widgets/my_books_pagination_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/entities/book/book.dart';
// import '../../../../books/presentation/widgets/book_card_item.dart';
// import '../../../../books/presentation/widgets/books_pagination_widget.dart';
// import '../bloc/my_books_bloc.dart';

// class StudentMyBooksItemsGridWidget extends StatefulWidget {
//   const StudentMyBooksItemsGridWidget({super.key});

//   @override
//   State<StudentMyBooksItemsGridWidget> createState() =>
//       _StudentMyBooksItemsGridWidgetState();
// }

// class _StudentMyBooksItemsGridWidgetState
//     extends State<StudentMyBooksItemsGridWidget> {
//   @override
//   void initState() {
//     BlocProvider.of<MyBooksBloc>(context).add(FetchMyBooks());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: MyBooksPaginationWidget<Book>(
//         loadMore: () {
//           BlocProvider.of<MyBooksBloc>(context).add(FetchMyBooks());
//         },
//         child: (Book book) {
//           return BookCardItem(catListKey: GlobalKey(), book: book);
//         },
//       ),
//     );
//   }
// }

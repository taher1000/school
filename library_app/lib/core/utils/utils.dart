import 'package:library_app/core/uscecase/usecase.dart';
import 'package:library_app/features/student_features/my_books/domain/parameters/book_params.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../features/student_features/my_books/presentation/bloc/my_books_bloc.dart';
import '../entities/book/book.dart';

class AppUtils {
  dynamic bookLevelCheck(int? bookLevel) {
    return bookLevel == null || bookLevel == 0 ? "" : bookLevel;
  }

  void appendPage({
    required PagingController pagingController,
    required bool isLastPage,
    required dynamic data,
  }) {
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      // pageKey++;
      pagingController.nextPageKey = pagingController.nextPageKey! + 1;
      pagingController.appendPage(data, pagingController.nextPageKey!);
    }
  }
}

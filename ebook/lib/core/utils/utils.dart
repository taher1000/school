import 'package:ebook/core/uscecase/usecase.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../features/student_features/my_books/presentation/bloc/my_books_bloc.dart';

class AppUtils {
  fetchPage(
      {required UseCase getUseCase,
      required dynamic params,
      required PagingController pagingController,
      required int pageKey}) async {
    try {
      final newItems = await getUseCase.call(p: params);
      newItems.fold((l) => GetMyBooksError(message: l.message), (r) {
        final isLastPage = !r.nextPage!;
        if (isLastPage) {
          pagingController.appendLastPage(r.data);
        } else {
          // final int nextPageKey = pageKey++;
          pagingController.appendPage(r.data, pageKey);
        }
      });
    } catch (error) {
      pagingController.error = error;
    }
  }
}

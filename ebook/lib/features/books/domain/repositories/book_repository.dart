import 'package:dartz/dartz.dart';
import '../../../../core/models/book/response/book_summary_response.dart';

import '../../../../core/network/failure.dart';

abstract class IBookRepository {
  Future<Either<Failure, BookSummaryResponsePage>> getBooks(int pageNumber,
      {required int pageSize, int? bookLevel});
  // Future<Either<Failure, BookSummaryResponsePage>> getBook(String id);
}

import 'package:dartz/dartz.dart';
import '../entities/book.dart';

import '../../../../core/network/failure.dart';
import '../../data/models/response/book_summary_response.dart';

abstract class IBookRepository {
  Future<Either<Failure, BookSummaryResponsePage>> getBooks(int pageNumber,
      {int pageSize, int? bookLevel});
  // Future<Either<Failure, BookSummaryResponsePage>> getBook(String id);
}

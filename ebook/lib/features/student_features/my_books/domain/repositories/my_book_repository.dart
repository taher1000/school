import 'package:dartz/dartz.dart';
import '../../../../../core/models/book/response/book_summary_response.dart';
import '../../../../../core/network/failure.dart';

abstract class IMyBookRepository {
  Future<Either<Failure, BookSummaryResponsePage>> getMyBooks(int pageNumber,
      {int pageSize, int? bookLevel});
  // Future<Either<Failure, BookSummaryResponsePage>> getBook(String id);
}

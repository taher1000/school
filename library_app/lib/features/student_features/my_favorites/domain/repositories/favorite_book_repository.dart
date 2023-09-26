import 'package:dartz/dartz.dart';
import '../../../../../core/models/assignment/student_assignment_summary_response.dart';
import '../../data/models/favorite_book_summary_response.dart';

import '../../../../../core/network/failure.dart';

abstract class IMyFavoriteBooksRepository {
  Future<Either<Failure, FavoriteBookSummaryResponsePage>> getMyFavoriteBooks(
      int pageNumber,
      {required int pageSize});

  Future<Either<Failure, String>> addMyFavoriteBook(String bookId);

  Future<Either<Failure, bool>> isFavoriteBook(String bookId);
}

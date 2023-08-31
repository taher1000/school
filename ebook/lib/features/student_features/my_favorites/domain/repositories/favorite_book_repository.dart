import 'package:dartz/dartz.dart';
import 'package:ebook/core/models/assignment/student_assignment_summary_response.dart';
import 'package:ebook/features/student_features/my_favorites/data/models/favorite_book_summary_response.dart';

import '../../../../../core/network/failure.dart';

abstract class IMyFavoriteBooksRepository {
  Future<Either<Failure, FavoriteBookSummaryResponsePage>> getMyFavoriteBooks(
      int pageNumber,
      {int pageSize,
      int? bookLevel});

  Future<Either<Failure, String>> addMyFavoriteBook(String bookId);

  Future<Either<Failure, bool>> isFavoriteBook(String bookId);
}

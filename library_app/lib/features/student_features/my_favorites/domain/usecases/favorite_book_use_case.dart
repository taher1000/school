import 'package:dartz/dartz.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../data/models/favorite_book_summary_response.dart';
import '../repositories/favorite_book_repository.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';

class GetMyFavoriteBooksMyUseCase extends UseCase<
    Either<Failure, FavoriteBookSummaryResponsePage>, PaginationParameters> {
  final IMyFavoriteBooksRepository repository;
  GetMyFavoriteBooksMyUseCase(this.repository);
  @override
  Future<Either<Failure, FavoriteBookSummaryResponsePage>> call(
      {PaginationParameters? p}) async {
    return await repository.getMyFavoriteBooks(p!.pageNumber,
        pageSize: p.pageSize);
  }
}

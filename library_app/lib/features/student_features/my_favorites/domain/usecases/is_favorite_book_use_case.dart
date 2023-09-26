import 'package:dartz/dartz.dart';
import '../repositories/favorite_book_repository.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';

class IsFavoriteBookUseCase extends UseCase<Either<Failure, bool>, String> {
  final IMyFavoriteBooksRepository repository;
  IsFavoriteBookUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call({String? p}) async {
    return await repository.isFavoriteBook(p!);
  }
}

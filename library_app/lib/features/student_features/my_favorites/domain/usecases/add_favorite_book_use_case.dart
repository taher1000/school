import 'package:dartz/dartz.dart';
import '../repositories/favorite_book_repository.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';

class AddMyFavoriteBookUseCase
    extends UseCase<Either<Failure, String>, String> {
  final IMyFavoriteBooksRepository repository;
  AddMyFavoriteBookUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call({String? p}) async {
    return await repository.addMyFavoriteBook(p!);
  }
}

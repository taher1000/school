import 'package:dartz/dartz.dart';
import '../parameters/book_params.dart';
import '../repositories/my_book_repository.dart';

import '../../../../../core/models/book/response/book_summary_response.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';

class GetMyBooksUseCase
    extends UseCase<Either<Failure, BookSummaryResponsePage>, MyBookParams> {
  final IMyBookRepository repository;
  GetMyBooksUseCase(this.repository);
  @override
  Future<Either<Failure, BookSummaryResponsePage>> call(
      {MyBookParams? p}) async {
    final res = await repository.getMyBooks(p!.pageNumber,
        pageSize: p.pageSize, bookLevel: p.bookLevel, search: p.search);
    return res;
  }
}

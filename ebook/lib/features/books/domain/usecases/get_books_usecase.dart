import 'package:dartz/dartz.dart';
import '../../data/models/response/book_summary_response.dart';
import '../entities/book.dart';
import '../repositories/book_repository.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/params/pagination_params.dart';
import '../../../../core/uscecase/usecase.dart';

class GetBooksUseCase extends UseCase<Either<Failure, BookSummaryResponsePage>,
    PaginationParameters> {
  final IBookRepository repository;
  GetBooksUseCase(this.repository);
  @override
  Future<Either<Failure, BookSummaryResponsePage>> call(
      {PaginationParameters? p}) async {
    return await repository.getBooks(p!.pageNumber, pageSize: p.pageSize);
  }
}

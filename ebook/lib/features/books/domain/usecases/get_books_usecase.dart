import 'package:dartz/dartz.dart';
import 'package:ebook/features/books/domain/parameters/book_params.dart';
import '../../../../core/models/response/book_summary_response.dart';
import '../repositories/book_repository.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/uscecase/usecase.dart';

class GetBooksUseCase
    extends UseCase<Either<Failure, BookSummaryResponsePage>, BookParams> {
  final IBookRepository repository;
  GetBooksUseCase(this.repository);
  @override
  Future<Either<Failure, BookSummaryResponsePage>> call({BookParams? p}) async {
    return await repository.getBooks(p!.pageNumber,
        pageSize: p.pageSize!, bookLevel: p.bookLevel);
  }
}

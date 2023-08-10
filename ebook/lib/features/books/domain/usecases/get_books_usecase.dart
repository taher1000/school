import 'package:dartz/dartz.dart';
import 'package:ebook/features/books/domain/entities/book.dart';
import 'package:ebook/features/books/domain/repositories/book_repository.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/params/pagination_params.dart';
import '../../../../core/uscecase/usecase.dart';

class GetBooksUseCase
    extends UseCase<Either<Failure, List<Book>>, PaginationParameters> {
  final IBookRepository repository;
  GetBooksUseCase(this.repository);
  @override
  Future<Either<Failure, List<Book>>> call({PaginationParameters? p}) async {
    return await repository.getBooks(p!.pageNumber, pageSize: p.pageSize);
  }
}

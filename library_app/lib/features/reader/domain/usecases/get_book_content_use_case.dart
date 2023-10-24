import 'package:dartz/dartz.dart';
import 'package:library_app/features/reader/data/parameters/book_content_params.dart';
import '../../data/models/book_content_summary_response.dart';
import '../entities/request/book_completed_status.dart';
import '../../../student_features/my_books/domain/repositories/my_book_repository.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/uscecase/usecase.dart';
import '../repositories/reader_repository.dart';

class GetBookContentUseCase extends UseCase<
    Either<Failure, BookContentSummaryResponsePage>, BookContentParams> {
  final IReaderRepository repository;
  GetBookContentUseCase(this.repository);
  @override
  Future<Either<Failure, BookContentSummaryResponsePage>> call(
      {BookContentParams? p}) async {
    final res = await repository.getBookContent(p!);
    return res;
  }
}

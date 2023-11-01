import 'package:dartz/dartz.dart';
import '../entities/request/book_completed_status.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/uscecase/usecase.dart';
import '../repositories/reader_repository.dart';

class SaveStudentBookStatusUseCase
    extends UseCase<Either<Failure, String>, BookCompletedStatus> {
  final IReaderRepository repository;
  SaveStudentBookStatusUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call({BookCompletedStatus? p}) async {
    final res = await repository.saveStudentBookStatus(p!);
    return res;
  }
}

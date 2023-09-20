import 'package:dartz/dartz.dart';
import '../../../../../core/network/failure.dart';
import '../entities/request/book_completed_status.dart';

abstract class IReaderRepository {
  Future<Either<Failure, String>> saveStudentBookStatus(
      BookCompletedStatus bookCompletedStatus);
}

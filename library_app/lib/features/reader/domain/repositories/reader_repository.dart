import 'package:dartz/dartz.dart';
import '../../../../../core/network/failure.dart';
import '../../data/models/book_content_summary_response.dart';
import '../../data/parameters/book_content_params.dart';
import '../entities/request/book_completed_status.dart';

abstract class IReaderRepository {
  Future<Either<Failure, String>> saveStudentBookStatus(
      BookCompletedStatus bookCompletedStatus);
  Future<Either<Failure, BookContentSummaryResponsePage>> getBookContent(
      BookContentParams bookContentParams);
}

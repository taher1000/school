import 'package:library_app/core/params/pagination_params.dart';

class AssignmentStatisticsParams extends PaginationParameters {
  final String? studentID;
  final String? bookID;

  const AssignmentStatisticsParams({
    required super.pageNumber,
    required super.pageSize,
    this.studentID,
    this.bookID,
  });
}

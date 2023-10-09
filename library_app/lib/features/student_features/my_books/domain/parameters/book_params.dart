import 'package:equatable/equatable.dart';
import 'package:library_app/core/params/pagination_params.dart';

class MyBookParams extends PaginationParameters {
  final int? bookLevel;

  const MyBookParams({
    required super.pageNumber,
    required super.pageSize,
    this.bookLevel,
  });

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
        bookLevel,
      ];
}

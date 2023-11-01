import 'package:library_app/core/params/pagination_params.dart';

class MyBookParams extends PaginationParameters {
  final int? bookLevel;
  final String? search;
  const MyBookParams({
    required super.pageNumber,
    required super.pageSize,
    this.bookLevel,
    this.search,
  });

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
        bookLevel,
        search,
      ];
}

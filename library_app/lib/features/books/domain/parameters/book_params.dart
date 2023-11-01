
import '../../../../core/params/pagination_params.dart';

class BookParams extends PaginationParameters {
  final int? bookLevel;
  final String? search;
  const BookParams({
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

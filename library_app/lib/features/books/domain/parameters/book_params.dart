import 'package:equatable/equatable.dart';

import '../../../../core/params/pagination_params.dart';

class BookParams extends PaginationParameters {
  final int? bookLevel;

  const BookParams({
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

import 'package:equatable/equatable.dart';

class BookParams extends Equatable {
  final int pageNumber;
  final int? pageSize;
  final int? bookLevel;

  const BookParams({
    required this.pageNumber,
    this.pageSize,
    this.bookLevel,
  });

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
        bookLevel,
      ];
}

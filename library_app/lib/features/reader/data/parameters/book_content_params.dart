import 'package:equatable/equatable.dart';

class BookContentParams extends Equatable {
  final int pageSize;
  final int pageNumber;
  final String bookId;
  const BookContentParams({
    required this.pageSize,
    required this.pageNumber,
    required this.bookId,
  });

  @override
  List<Object?> get props => [
        pageSize,
        pageNumber,
        bookId,
      ];
}

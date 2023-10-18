import 'package:equatable/equatable.dart';

class PaginationParameters extends Equatable {
  final int pageNumber;
  final int pageSize;
  const PaginationParameters(
      {required this.pageNumber, required this.pageSize});

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
      ];
}

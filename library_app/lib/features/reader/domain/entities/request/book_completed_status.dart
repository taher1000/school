import 'package:equatable/equatable.dart';

import '../../../data/models/book_completed_status.dart';

class BookCompletedStatus extends Equatable {
  final String bookId;
  final bool hasReadingCompleted;
  final bool hasListeningCompleted;

  const BookCompletedStatus({
    required this.bookId,
    required this.hasReadingCompleted,
    required this.hasListeningCompleted,
  });

  BookCompletedStatusModel toModel() => BookCompletedStatusModel(
        bookId: bookId,
        hasReadingCompleted: hasReadingCompleted,
        hasListeningCompleted: hasListeningCompleted,
      );

  @override
  List<Object?> get props => [
        bookId,
        hasReadingCompleted,
        hasListeningCompleted,
      ];
}

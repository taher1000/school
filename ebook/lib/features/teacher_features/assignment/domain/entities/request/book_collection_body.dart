import 'package:ebook/features/teacher_features/assignment/data/models/request/assignment_post_request.dart';
import 'package:equatable/equatable.dart';

class BookCollection extends Equatable {
  final String bookId;
  final bool hasBookRead;
  final bool hasBookAudio;

  const BookCollection({
    required this.bookId,
    required this.hasBookRead,
    required this.hasBookAudio,
  });

  BookCollectionModel toModel() => BookCollectionModel(
        bookId: bookId,
        hasBookRead: hasBookRead,
        hasBookAudio: hasBookAudio,
      );

  @override
  List<Object?> get props => [bookId, hasBookRead, hasBookAudio];
}

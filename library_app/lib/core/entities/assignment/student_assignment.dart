import 'package:library_app/core/entities/book/book.dart';

class StudentAssignment extends Book {
  const StudentAssignment({
    required super.id,
    required super.title,
    required super.description,
    required super.bookLevel,
    required super.image,
    required super.bookLanguage,
    required super.pageCount,
    required super.wordCount,
    required super.isActive,
    required super.authorName,
    required super.authorAddress,
    required super.publisherName,
    required super.publisherAddress,
    required super.imageId,
    required super.hasListening,
    required super.hasReading,
    required super.hasReadingCompleted,
    required super.hasListeningCompleted,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        bookLevel,
        image,
        bookLanguage,
        pageCount,
        wordCount,
        isActive,
        authorName,
        authorAddress,
        publisherName,
        publisherAddress,
      ];
}

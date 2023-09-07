import '../../../../../core/entities/book/book.dart';

class FavoriteBook extends Book {
  const FavoriteBook({
    required super.id,
    required super.title,
    required super.description,
    required super.bookLevel,
    required super.document,
    required super.image,
    required super.bookLanguage,
    required super.pageCount,
    required super.wordCount,
    required super.isActive,
    required super.authorName,
    required super.authorAddress,
    required super.publisherName,
    required super.publisherAddress,
    required super.documentId,
    required super.imageId,
    required super.hasListening,
    required super.hasReading,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        bookLevel,
        document,
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

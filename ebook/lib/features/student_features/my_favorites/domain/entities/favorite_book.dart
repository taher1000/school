import '../../../../../core/entities/book/book.dart';

class FavoriteBook extends Book {
  const FavoriteBook({
    required super.bookId,
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
  });

  @override
  List<Object?> get props => [
        bookId,
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

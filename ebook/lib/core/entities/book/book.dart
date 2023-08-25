import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final int? bookLevel;
  final String? document;
  final String? image;
  final bool? isActive;
  final String? authorName;
  final String? authorAddress;
  final String? publisherName;
  final String? publisherAddress;
  final String? gridId;

  final String? bookId;

  final String? bookLanguage;
  final int? pageCount;
  final int? wordCount;

  const Book({
    this.id,
    this.title,
    this.description,
    this.bookLevel,
    this.document,
    this.image,
    this.isActive,
    this.authorName,
    this.authorAddress,
    this.publisherName,
    this.publisherAddress,
    this.gridId,
    this.bookId,
    this.bookLanguage,
    this.pageCount,
    this.wordCount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        bookLevel,
        document,
        image,
        isActive,
        authorName,
        authorAddress,
        publisherName,
        publisherAddress,
        gridId,
        bookId,
        bookLanguage,
        pageCount,
        wordCount,
      ];
}

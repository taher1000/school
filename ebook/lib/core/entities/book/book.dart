import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String id;
  final String title;
  final String description;
  final int bookLevel;
  final String document;
  final String image;
  final String? bookLanguage;
  final int pageCount;
  final int wordCount;
  final bool isActive;
  final String? authorName;
  final String? authorAddress;
  final String? publisherName;
  final String? publisherAddress;

  const Book({
    required this.id,
    required this.title,
    required this.description,
    required this.bookLevel,
    required this.document,
    required this.image,
    required this.bookLanguage,
    required this.pageCount,
    required this.wordCount,
    required this.isActive,
    required this.authorName,
    required this.authorAddress,
    required this.publisherName,
    required this.publisherAddress,
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
        bookLanguage,
        pageCount,
        wordCount,
      ];
}

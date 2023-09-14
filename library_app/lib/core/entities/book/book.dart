import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String id;
  final String title;
  final String description;
  final int bookLevel;
  final String image;
  final String bookLanguage;
  final int pageCount;
  final int wordCount;
  final bool hasReading;
  final bool hasListening;
  final bool isActive;
  final String authorName;
  final String authorAddress;
  final String publisherName;
  final String publisherAddress;
  final String documentId;
  final String imageId;

  const Book({
    required this.id,
    required this.title,
    required this.description,
    required this.bookLevel,
    required this.image,
    required this.bookLanguage,
    required this.pageCount,
    required this.wordCount,
    required this.hasReading,
    required this.hasListening,
    required this.isActive,
    required this.authorName,
    required this.authorAddress,
    required this.publisherName,
    required this.publisherAddress,
    required this.documentId,
    required this.imageId,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        bookLevel,
        image,
        isActive,
        authorName,
        authorAddress,
        publisherName,
        publisherAddress,
        bookLanguage,
        pageCount,
        wordCount,
        hasReading,
        hasListening,
        documentId,
        imageId,
      ];
}

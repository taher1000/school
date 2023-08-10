import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String? bookId;
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

  const Book({
    this.bookId,
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
  });

  @override
  List<Object?> get props => [
        bookId,
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
      ];
}

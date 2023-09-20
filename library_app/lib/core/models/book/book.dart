import '../../entities/book/book.dart';

class BookModel extends Book {
  const BookModel({
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

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json["bookID"],
      title: json["title"],
      description: json["description"],
      bookLevel: json["bookLevel"],
      image: json["image"],
      bookLanguage: json["bookLanguage"],
      pageCount: json["pageCount"],
      wordCount: json["wordCount"],
      isActive: json["isActive"],
      authorName: json["authorName"],
      authorAddress: json["authorAddress"],
      publisherName: json["publisherName"],
      publisherAddress: json["publisherAddress"],
      imageId: json["imageID"],
      hasReading: json["hasReading"],
      hasListening: json["hasListening"],
      hasReadingCompleted: json["hasReadingCompleted"],
      hasListeningCompleted: json["hasListeningCompleted"],
    );
  }
}

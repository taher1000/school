import '../../entities/book/book.dart';

class BookModel extends Book {
  const BookModel({
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

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json["bookID"],
      title: json["title"],
      description: json["description"],
      bookLevel: json["bookLevel"],
      document: json["document"],
      image: json["image"],
      bookLanguage: json["bookLanguage"],
      pageCount: json["pageCount"],
      wordCount: json["wordCount"],
      isActive: json["isActive"],
      authorName: json["authorName"],
      authorAddress: json["authorAddress"],
      publisherName: json["publisherName"],
      publisherAddress: json["publisherAddress"],
      documentId: json["documentID"],
      imageId: json["imageID"],
      hasReading: json["hasReading"],
      hasListening: json["hasListening"],
    );
  }
}

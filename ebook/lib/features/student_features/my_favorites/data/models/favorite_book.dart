import '../../domain/entities/favorite_book.dart';

class FavoriteBookModel extends FavoriteBook {
  const FavoriteBookModel({
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

  factory FavoriteBookModel.fromJson(Map<String, dynamic> json) =>
      FavoriteBookModel(
        bookId: json["bookID"],
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
      );

  Map<String, dynamic> toJson() => {
        "bookID": bookId,
        "title": title,
        "description": description,
        "bookLevel": bookLevel,
        "document": document,
        "image": image,
        "bookLanguage": bookLanguage,
        "pageCount": pageCount,
        "wordCount": wordCount,
        "isActive": isActive,
        "authorName": authorName,
        "authorAddress": authorAddress,
        "publisherName": publisherName,
        "publisherAddress": publisherAddress,
      };
}

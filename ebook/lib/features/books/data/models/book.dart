import '../../domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    String? id,
    String? title,
    String? description,
    int? bookLevel,
    String? document,
    String? image,
    bool? isActive,
    String? authorName,
    String? authorAddress,
    String? publisherName,
    String? publisherAddress,
    String? gridId,
  }) : super(
          id: id,
          title: title,
          description: description,
          bookLevel: bookLevel,
          document: document,
          image: image,
          isActive: isActive,
          authorName: authorName,
          authorAddress: authorAddress,
          publisherName: publisherName,
          publisherAddress: publisherAddress,
          gridId: gridId,
        );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['bookId'],
      title: json['title'],
      description: json['description'],
      bookLevel: json['bookLevel'],
      document: json['document'],
      image: json['image'],
      isActive: json['isActive'],
      authorName: json['authorName'],
      authorAddress: json['authorAddress'],
      publisherName: json['publisherName'],
      publisherAddress: json['publisherAddress'],
      gridId: json['gridId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookId': id,
      'title': title,
      'description': description,
      'bookLevel': bookLevel,
      'document': document,
      'image': image,
      'isActive': isActive,
      'authorName': authorName,
      'authorAddress': authorAddress,
      'publisherName': publisherName,
      'publisherAddress': publisherAddress,
      'gridId': gridId,
    };
  }
}

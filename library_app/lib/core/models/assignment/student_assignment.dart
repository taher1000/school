import 'package:library_app/core/entities/assignment/student_assignment.dart';

class StudentAssignmentModel extends StudentAssignment {
  const StudentAssignmentModel({
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

  factory StudentAssignmentModel.fromJson(Map<String, dynamic> json) =>
      StudentAssignmentModel(
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

  Map<String, dynamic> toJson() => {
        "bookID": id,
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

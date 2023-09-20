// To parse this JSON data, do
//
//     final bookCompletedStatusModel = bookCompletedStatusModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/request/book_completed_status.dart';

String bookCompletedStatusModelToJson(BookCompletedStatusModel data) =>
    json.encode(data.toJson());

class BookCompletedStatusModel extends BookCompletedStatus {
  const BookCompletedStatusModel({
    required super.bookId,
    required super.hasReadingCompleted,
    required super.hasListeningCompleted,
  });

  Map<String, dynamic> toJson() => {
        "bookID": bookId,
        "hasReadingCompleted": hasReadingCompleted,
        "hasListeningCompleted": hasListeningCompleted,
      };
}

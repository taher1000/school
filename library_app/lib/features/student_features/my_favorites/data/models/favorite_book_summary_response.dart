import 'dart:convert';

import '../../../../../core/models/assignment/student_assignment.dart';

import '../../../../../core/network/api_response_model.dart';
import 'favorite_book.dart';

class FavoriteBookSummaryResponsePage extends ApiResponse {
  FavoriteBookSummaryResponsePage({
    super.data,
    super.succeeded,
    super.errors,
    super.message,
    required super.pageNumber,
    super.pageSize,
    super.totalRecords,
    super.nextPage,
    super.totalPages,
  });

  factory FavoriteBookSummaryResponsePage.fromRawJson(String str) =>
      FavoriteBookSummaryResponsePage.fromJson(json.decode(str));

  factory FavoriteBookSummaryResponsePage.fromJson(Map<String, dynamic> json) =>
      FavoriteBookSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<FavoriteBookModel>.from(
                json["data"].map((x) => FavoriteBookModel.fromJson(x))),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}

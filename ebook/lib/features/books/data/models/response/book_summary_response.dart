import 'dart:convert';

import 'package:ebook/core/network/api_response_model.dart';
import 'package:ebook/features/books/data/models/book.dart';

class BookSummaryResponsePage extends ApiResponse {
  BookSummaryResponsePage({
    super.data,
    super.succeeded,
    super.errors,
    super.message,
    required super.pageNumber,
    super.pageSize,
    super.totalRecords,
    super.isLastPage,
    super.totalPages,
  });

  factory BookSummaryResponsePage.fromRawJson(String str) =>
      BookSummaryResponsePage.fromJson(json.decode(str));

  factory BookSummaryResponsePage.fromJson(Map<String, dynamic> json) =>
      BookSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<BookModel>.from(
                json["data"].map((x) => BookModel.fromJson(x))),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        isLastPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}

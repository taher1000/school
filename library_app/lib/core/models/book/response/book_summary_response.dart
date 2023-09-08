import 'dart:convert';

import '../../../../../core/network/api_response_model.dart';
import '../book.dart';

class BookSummaryResponsePage extends ApiResponse {
  // final List<BookModel> data;
  BookSummaryResponsePage({
    required super.data,
    super.succeeded,
    super.errors,
    super.message,
    required super.pageNumber,
    super.pageSize,
    super.totalRecords,
    super.nextPage,
    super.totalPages,
  });
  //: super(data: data);

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
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}

import 'dart:convert';

import '../../../../../../core/network/api_response_model.dart';

class BookContentSummaryResponsePage extends ApiResponse {
  BookContentSummaryResponsePage({
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

  factory BookContentSummaryResponsePage.fromRawJson(String str) =>
      BookContentSummaryResponsePage.fromJson(json.decode(str));

  factory BookContentSummaryResponsePage.fromJson(Map<String, dynamic> json) =>
      BookContentSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<String>.from(json["data"]!.map((x) => x)),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}

import 'dart:convert';

import 'package:ebook/core/network/api_response_model.dart';

import 'assignment_model.dart';

class AssignmentSummaryResponsePage extends ApiResponse {
  AssignmentSummaryResponsePage({
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

  factory AssignmentSummaryResponsePage.fromRawJson(String str) =>
      AssignmentSummaryResponsePage.fromJson(json.decode(str));

  factory AssignmentSummaryResponsePage.fromJson(Map<String, dynamic> json) =>
      AssignmentSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<AssignmentModel>.from(
                json["data"].map((x) => AssignmentModel.fromJson(x))),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        isLastPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}

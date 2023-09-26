import 'dart:convert';
import 'question.dart';

import '../../../../../core/network/api_response_model.dart';

class QuestionsSummaryResponsePage extends ApiResponse {
  QuestionsSummaryResponsePage({
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

  factory QuestionsSummaryResponsePage.fromRawJson(String str) =>
      QuestionsSummaryResponsePage.fromJson(json.decode(str));

  factory QuestionsSummaryResponsePage.fromJson(Map<String, dynamic> json) =>
      QuestionsSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<QuestionModel>.from(
                json["data"].map((x) => QuestionModel.fromJson(x))),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}

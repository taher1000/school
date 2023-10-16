import 'dart:convert';

import 'package:library_app/features/teacher_features/assignment_statistics/domain/entities/assignment_statistics.dart';

import '../../../../../core/network/api_response_model.dart';
import 'assignment_statistics.dart';

class AssignmentsStatisticsSummaryResponsePage extends ApiResponse {
  AssignmentsStatisticsSummaryResponsePage({
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

  factory AssignmentsStatisticsSummaryResponsePage.fromRawJson(String str) =>
      AssignmentsStatisticsSummaryResponsePage.fromJson(json.decode(str));

  factory AssignmentsStatisticsSummaryResponsePage.fromJson(
          Map<String, dynamic> json) =>
      AssignmentsStatisticsSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<AssignmentStatistics>.from(
                json["data"].map((x) => AssignmentStatisticsModel.fromJson(x))),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}

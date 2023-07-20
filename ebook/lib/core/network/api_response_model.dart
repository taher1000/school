class ApiResponse {
  late dynamic data;
  final bool? succeeded;
  final List<String>? errors;

  final String? message;

  ApiResponse({this.data, this.errors, this.succeeded, this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json, {String? dataTag}) {
    return ApiResponse(
      succeeded: json["succeeded"],
      message: json["message"],
      errors: json["errors"],
      data: json[dataTag] ?? [],
    );
  }
}

class DefaultResponse {
  DefaultResponse({
    this.data,
    this.status,
  });

  DefaultResponse.fromJson(dynamic json) {
    data = json['data'] ?? false;
    status = json['status'] ?? false;
  }

  bool? data;
  bool? status;
  String? message;
}

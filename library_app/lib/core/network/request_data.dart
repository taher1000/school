class RequestData {
  Map<String, dynamic> headers;
  Map<String, dynamic> params;
  dynamic data;

  RequestData({
    required this.data,
    required this.headers,
    required this.params,
  });
}

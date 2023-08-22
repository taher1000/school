class AuthResponse {
  final String? email;
  final String? userName;
  final int? userRole;
  final String? englishFullName;
  final String? arabicFullName;
  final DateTime? birthDate;
  final String? phoneNumber;
  final String? token;
  final String? refreshToken;

  AuthResponse({
    this.email,
    this.userName,
    this.userRole,
    this.englishFullName,
    this.arabicFullName,
    this.birthDate,
    this.phoneNumber,
    this.token,
    this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        email: json["email"],
        userName: json["userName"],
        userRole: 4,
        // json["userRole"],
        englishFullName: json["englishFullName"],
        arabicFullName: json["arabicFullName"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        phoneNumber: json["phoneNumber"],
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "userName": userName,
        "userRole": userRole,
        "englishFullName": englishFullName,
        "arabicFullName": arabicFullName,
        "birthDate": birthDate?.toIso8601String(),
        "phoneNumber": phoneNumber,
        "token": token,
        "refreshToken": refreshToken,
      };
}

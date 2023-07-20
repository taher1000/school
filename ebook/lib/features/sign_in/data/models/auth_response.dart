class AuthResponse {
  String? email;
  List<String>? errors;
  String? accessToken;
  String? phoneNumber;
  String? userName;
  String? englishFullName;
  String? arabicFullName;
  DateTime? birthDate;

  AuthResponse({
    this.email,
    this.errors,
    this.accessToken,
    this.phoneNumber,
    this.userName,
    this.englishFullName,
    this.arabicFullName,
    this.birthDate,
  });

  AuthResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    errors = json['errors'];
    accessToken = json['token'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    englishFullName = json['englishFullName'];
    arabicFullName = json['arabicFullName'];
    birthDate = json['birthDate'] != null
        ? DateTime.parse(json['birthDate'])
        : DateTime.now();
  }
}

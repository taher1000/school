import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() => {
        'token': accessToken,
        'refreshToken': refreshToken,
      };
}

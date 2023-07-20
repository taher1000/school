import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.accessToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
      };
}

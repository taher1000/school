import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String accessToken;
  final String refreshToken;

  const Auth({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken];

  @override
  bool? get stringify => true;
}

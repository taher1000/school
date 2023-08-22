class AuthParameters {
  final String email;
  final String password;
  final String deviceId;
  final bool isAndroidDevice;
  const AuthParameters({
    required this.email,
    required this.password,
    required this.deviceId,
    required this.isAndroidDevice,
  });
}

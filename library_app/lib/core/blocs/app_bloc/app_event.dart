part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class FirebaseLogEvents extends AppEvent {
  final String? name;
  final Map<String, Object?>? parameters;

  FirebaseLogEvents({this.name, this.parameters});
}

class InitApp extends AppEvent {}

class UpdateAuthAppEvent extends AppEvent {
  final UserAuthStatus? userAuthStatus;
  UpdateAuthAppEvent({
    this.userAuthStatus,
  });
}

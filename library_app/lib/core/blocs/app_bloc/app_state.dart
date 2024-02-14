part of 'app_bloc.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class GetUserDataState extends AppState {}

class LoadingState extends AppState {}

class FailedState extends AppState {
  final String message;
  FailedState(this.message);
}

class DoneState extends AppState {}

class NotFoundState extends AppState {}

class NoInternetConnectionState extends AppState {}

class ServerExceptionState extends AppState {}

class UnAuthorizationExceptionState extends AppState {}

class BadRequestExceptionState extends AppState {}

class UserSignedInSuccess extends AppState {}

class UserNotSignedIn extends AppState {}

class UserHaveNoProgram extends AppState {}

class UserAuthState extends AppState {
  final UserAuthStatus userAuthStatus;
  UserAuthState(this.userAuthStatus);
}

enum UserAuthStatus {
  signedIn,
  signedOut,
  userNeedUpdate,
  firstTimeLogin,
  userHasNoInternetConnection,
  userShouldAgreePrivacy,
  userAgreePrivacyMessage,
  updateMobileDate,
  reachMaximumCall,
  userUnAuthorized,
  serverError
}

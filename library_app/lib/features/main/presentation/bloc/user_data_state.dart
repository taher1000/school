part of 'user_data_bloc.dart';

@immutable
abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserDataState {}

class GetAllDataSuccess extends UserDataState {}

class GetAllDataLoading extends UserDataState {}

class GetAllDataFailed extends UserDataState {}

class UserDataFailed extends UserDataState {
  final String errorMessage;
  const UserDataFailed(this.errorMessage);
}

class Loading extends UserDataState {}

class UserDataSuccess extends UserDataState {
  final User user;
  const UserDataSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class SendOTPSuccess extends UserDataState {}

class SendOTPError extends UserDataState {
  const SendOTPError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class UserChangeDataError extends UserDataState {
  const UserChangeDataError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class UserChangeDataLoading extends UserDataState {}

class UserChangeDataSuccess extends UserDataState {}

class CheckOTPSuccess extends UserDataState {
  final bool isTwoFactorAuth;
  const CheckOTPSuccess({this.isTwoFactorAuth = false});

  @override
  List<Object> get props => [isTwoFactorAuth];
}

class CheckError extends UserDataState {
  String error;

  CheckError(this.error);

  @override
  List<Object> get props => [error];
}

class CheckLoading extends UserDataState {
  const CheckLoading();
}

class CheckOTPLoading extends UserDataState {
  const CheckOTPLoading();
}

class CheckOTPError extends UserDataState {
  CheckOTPError({this.error});

  String? error;

  @override
  List<Object> get props => [error!];
}

class SendOtpLoading extends UserDataState {}

class SendOtpSuccess extends UserDataState {}

class SendOtpError extends UserDataState {
  SendOtpError({this.error});

  String? error;

  @override
  List<Object> get props => [error!];
}

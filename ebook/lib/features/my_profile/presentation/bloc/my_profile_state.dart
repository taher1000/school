part of 'my_profile_bloc.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object> get props => [];
}

class MyProfileInitial extends MyProfileState {}

class MyProfileLoading extends MyProfileState {}

class MyProfileLoaded extends MyProfileState {
  final UserData userData;

  const MyProfileLoaded(this.userData);

  @override
  List<Object> get props => [userData];
}

class MyProfileError extends MyProfileState {
  final String message;

  const MyProfileError(this.message);

  @override
  List<Object> get props => [message];
}

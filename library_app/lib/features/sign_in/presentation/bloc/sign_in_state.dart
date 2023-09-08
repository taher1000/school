part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  final String? errorMessage;

  const SignInState({this.errorMessage});

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInFailed extends SignInState {
  const SignInFailed(String errorMessage) : super(errorMessage: errorMessage);
}

class SignInSuccess extends SignInState {}

part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class Authenticate extends SignInEvent {
  final String email;
  final String password;

  const Authenticate({
    required this.email,
    required this.password,
  });
}

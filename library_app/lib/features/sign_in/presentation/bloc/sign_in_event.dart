part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class Authenticate extends SignInEvent {
  final AuthParameters authParams;

  const Authenticate({
    required this.authParams,
  });
}

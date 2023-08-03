part of 'user_data_bloc.dart';

@immutable
abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object?> get props => [];
}

class InitUser extends UserDataEvent {}

class ClearUserData extends UserDataEvent {}

class GetAllData extends UserDataEvent {}

class SetUserTermsAgreement extends UserDataEvent {
  bool agree;
  SetUserTermsAgreement(this.agree);
}

class Update extends UserDataEvent {
  const Update();
}

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../domain/usecases/user_usecase.dart';

import '../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../../../core/widgets/popup/privacy_pop_message.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/user.dart';

part 'user_data_event.dart';

part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final ProfileDataUseCase _userUseCases;
  User? userData;

  UserDataBloc(this._userUseCases) : super(UserDataInitial()) {
    on<UserDataEvent>((event, emit) async {
      if (event is ClearUserData) {
        userData = null;
        emit(UserDataInitial());
        sharedPrefsClient.clearUserData();
      } else if (event is GetAllData) {
        try {
          emit(GetAllDataLoading());
          _userUseCases.updateDeviceToken();
          _userUseCases.getAllData();

          add(InitUser());
        } catch (e) {
          emit(GetAllDataFailed());
        }
      } else if (event is InitUser) {
        emit(Loading());
        try {
          _userUseCases.checkUserTermsAgreement().then((agreeResponse) {
            agreeResponse.fold((l) {
              showCupertinoModalPopup(
                  context: currentContext!,
                  builder: (context) => const PrivacyPopMessage(),
                  barrierDismissible: false);
            }, (right) {
              if (right) {
                getUser();
              } else {
                currentContext!.read<AppBloc>().add(UpdateAuthAppEvent(
                    userAuthStatus: UserAuthStatus.userShouldAgreePrivacy));
              }
            });
          });
        } catch (e) {
          log("- $e");
        }
      } else if (event is SetUserTermsAgreement) {
        _userUseCases.setUserTermsAgreement(event.agree);
      } else if (event is Update) {
        emit(UserChangeDataSuccess());
      }
    });
  }

  getUser() async {
    _userUseCases().then((userRespose) {
      userRespose.fold((l) {
        emit(UserDataFailed(l));
        emit(GetAllDataFailed());
      }, (r) {
        sharedPrefsClient.email = r.email!;
        sharedPrefsClient.arabicFullName = r.arabicFullName!;
        sharedPrefsClient.englishFullName = r.englishFullName!;

        userData = r;

        _userUseCases.getUserImage().then((imageRespose) {
          imageRespose.fold((l) {
            log(l);
            emit(GetAllDataSuccess());

            emit(UserDataSuccess(userData!));
          }, (r) {
            if (r != null) {
              userData = userData?.copyWith(image: r);
              emit(GetAllDataSuccess());

              emit(UserDataSuccess(userData!));
            }
          });
        });
      });
    });
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../data/models/auth_response.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import '../../../../core/resources/routes_manager.dart';
import '../../../../injection_container.dart';
import '../../domain/params/auth_parameters.dart';
import '../../domain/usecases/auth_usecases.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticateUseCase _authenticationUseCases;
  Timer? timer;

  SignInBloc(this._authenticationUseCases) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      try {
        if (event is Authenticate) {
          emit(SignInLoading());

          var result = await Future.wait([
            _authenticationUseCases(
              p: AuthParameters(
                email: event.email,
                password: event.password,
                deviceId: "as",
                isAndroidDevice: Platform.isAndroid,
              ),
            ),
          ]);

          AuthResponse? data;
          result[0].fold((l) => emit(SignInFailed(l)), (r) {
            data = r;
            if (data != null) {
              if (sharedPrefsClient.email == "" ||
                  event.email != sharedPrefsClient.email ||
                  event.email == sharedPrefsClient.email) {
                try {
                  sharedPrefsClient.email = event.email;
                } catch (e) {
                  log('authenticateWithBiometrics :catch  ${e.toString()}');
                }
              }
            }

            emit(SignInSuccess());

            // CustomNavigator.push(
            //   Routes.homeRoute,
            // );
          });
          if (data != null) await saveUserData(data!);
        }
      } catch (e) {
        emit(const SignInFailed("error_message"));
      }
    });
  }

  Future<void> saveUserData(AuthResponse data) async {
    sharedPrefsClient.accessToken = data.token;
    sharedPrefsClient.refreshToken = data.refreshToken;
    sharedPrefsClient.arabicFullName = data.arabicFullName;
    sharedPrefsClient.englishFullName = data.englishFullName;
    sharedPrefsClient.userName = data.userName;
    sharedPrefsClient.userRole = data.userRole!;
    sharedPrefsClient.email = data.email;
  }
}

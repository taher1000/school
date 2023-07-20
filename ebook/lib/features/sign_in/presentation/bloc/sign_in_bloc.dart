import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ebook/core/navigation/custom_navigation.dart';
import 'package:ebook/features/sign_in/data/models/auth_response.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

import '../../../../core/resources/routes_manager.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/auth.dart';
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
            CustomNavigator.push(
              Routes.homeRoute,
            );
          });
          if (data != null) await saveUserData(data!);
        }
      } catch (e) {
        emit(const SignInFailed("error_message"));
      }
    });
  }

  Future<void> saveUserData(AuthResponse data) async {
    sharedPrefsClient.accessToken = data.accessToken;
    sharedPrefsClient.email = data.email;
    log("token: ${sharedPrefsClient.accessToken}");
  }
}

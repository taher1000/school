import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ebook/core/network/school_rest.dart';

import '../../../../core/network/api_response_model.dart';
import '../../../../core/network/idm_rest.dart';
import '../../../../injection_container.dart';

abstract class IProfileRemoteDataSource {
  Future<Response> getUserData();
  // Future<Response> updateProfile(CheckOtpEmailOrPhoneParameters parameters);

  Future<ApiResponse> getAllData();

  Future<ApiResponse> updateDeviceToken();

  Future<ApiResponse> checkUserTermsAgreement();

  Future<ApiResponse> setUserTermsAgreement(bool agree);
  Future<ApiResponse> notificationRegisterUser(
      {required String deviceID, required String deviceType});
}

class ProfileRemoteDataSource implements IProfileRemoteDataSource {
  final IIDMRest _idmRest;
  final ISchoolRest _sanadRest;

  ProfileRemoteDataSource(this._idmRest, this._sanadRest);

  @override
  Future<Response> getUserData() async {
    final response = await _idmRest.getUserData();
    return response;
  }

  // @override
  // Future<Response> updateProfile(
  //     CheckOtpEmailOrPhoneParameters parameters) async {
  //   final response = await _idmRest.updateProfile(parameters);
  //   return response;
  // }

  @override
  Future<ApiResponse> getAllData() async {
    return await _sanadRest.get("User/GetAllData",
        userToken: sharedPrefsClient.accessToken);
  }

  @override
  Future<ApiResponse> updateDeviceToken() async {
    var body = jsonEncode({
      // "deviceID": sharedPrefsClient.deviceToken,
      // "deviceType": sharedPrefsClient.isGMS
      //     ? Platform.isAndroid
      //         ? 'Android'
      //         : 'Ios'
      //     : 'Huawei',
    });
    return await _sanadRest.post("User/NotificationRegisterUser",
        userToken: sharedPrefsClient.accessToken, data: body);
  }

  @override
  Future<ApiResponse> checkUserTermsAgreement() async {
    return await _sanadRest.get("User/User_TermsAgreement_Get",
        userToken: sharedPrefsClient.accessToken);
  }

  @override
  Future<ApiResponse> setUserTermsAgreement(bool agree) async {
    return await _sanadRest.get("User/User_TermsAgreement_Insert",
        userToken: sharedPrefsClient.accessToken,
        queryParameters: {"Agreed": agree});
  }

  @override
  Future<ApiResponse> notificationRegisterUser(
      {required String deviceID, required String deviceType}) async {
    return await _sanadRest.post("User/NotificationRegisterUser",
        userToken: sharedPrefsClient.accessToken,
        data: {"deviceID": deviceID, "deviceType": deviceType});
  }
}

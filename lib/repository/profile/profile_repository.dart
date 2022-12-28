import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';
import 'package:untitled/src/models/user.dart';

class ProfileRepository extends BaseRepository {
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Profile/ChangePassword',
        data: {"currentPassword": currentPassword, "newPassword": newPassword},
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getProfilePictureAPIRepository() async {
    try {
      var client = init();
      final profileResponse = await client.get(
        '/api/services/app/Profile/GetAvatarProfile',
      );

      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getCurrentUserProfileAPIRepository() async {
    try {
      var client = init();

      final profileResponse = await client.get(
        '/api/services/app/Profile/GetCurrentUserProfileForEdit',
      );

      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> updateProfilePictureAPIRepository(String imageUrl) async {
    try {
      var client = init();
      // upload image to asp.net core server

      final profileResponse = await client.put(
        '/api/services/app/Profile/UpdateAvatarProfile',
        queryParameters: {
          'url': imageUrl,
        },
      );

      print("respone update image: $profileResponse");
      return profileResponse;
    } on DioError catch (error) {
      print('error update image: ${error.toString()}');
      return error.response as Response;
    }
  }

  Future<Response> sendOTPToChangeEmailAPIRepository(String email) async {
    try {
      var client = init();
      print("Go in OTP");
      final profileResponse = await client.post(
          '/api/services/app/Account/SendEmailAddressOTP',
          data: {
            "emailAddress": email,
          },
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }));

      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> changePhoneNumberAPIRepository(
      MDUser? mdUser, String phoneNumber) async {
    try {
      var client = init();

      print(phoneNumber);
      final profileResponse = await client.put(
        '/api/services/app/Profile/UpdateCurrentUserProfile',
        data: {
          "emailAddress": mdUser!.email,
          "gender": mdUser.gender,
          "idNumber": mdUser.idNumber,
          "birthDate": mdUser.birthDate,
          "userName": mdUser.userName,
          "name": mdUser.name,
          "surname": mdUser.surname,
          "phoneNumber": phoneNumber,
          "apartmentId": mdUser.apartmentId,
        },
      );

      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> changeEmailAPIRepository(
      MDUser? mdUser, String email) async {
    try {
      var client = init();

      print(email);
      final profileResponse = await client.put(
        '/api/services/app/Profile/UpdateCurrentUserProfile',
        data: {
          "emailAddress": email,
          "gender": mdUser!.gender,
          "idNumber": mdUser.idNumber,
          "birthDate": mdUser.birthDate,
          "userName": mdUser.userName,
          "name": mdUser.name,
          "surname": mdUser.surname,
          "phoneNumber": mdUser.phoneNumber,
          "apartmentId": mdUser.apartmentId,
        },
      );

      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future checkOTPAPIRepository(String otp, String email) async {
    try {
      var client = init();

      final profileResponse = await client.post(
        '/api/services/app/Account/ConfirmEmailAddressOTP',
        data: {
          "emailAddress": email,
          "otp": otp,
        },
      );
      print(profileResponse.data['success']);
      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}

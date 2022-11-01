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
        '/api/services/app/Profile/GetProfilePicture',
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

  Future<Response> updateProfilePictureAPIRepository(File file) async {
    try {
      var client = init();
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "fileToken": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      final profileResponse = await client.put(
        '/api/services/app/Profile/UpdateProfilePicture',
        data: formData,
      );
      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> sendOTPToChangePhoneNumberAPIRepository(
      MDUser? mdUser) async {
    try {
      var client = init();
      print("Go in OTP");
      final profileResponse = await client.post(
        '/api/services/app/Profile/SendEmailActivationOTP',
        data: {
          "emailAddress": mdUser!.email,
          "gender": mdUser.gender,
          "idNumber": mdUser.idNumber,
          "birthDate": mdUser.birthDate,
          "userName": mdUser.userName,
          "name": mdUser.name,
          "surname": mdUser.surname,
        },
      );

      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> changePhoneNumberAPIRepository(
      MDUser? mdUser, String phoneNumber) async {
    try {
      var client = init();
      print("dt day");
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
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      print("res ne:");
      print(profileResponse.data);
      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}

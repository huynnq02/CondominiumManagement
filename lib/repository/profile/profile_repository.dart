import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

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

  Future<Response> updateProfilePictureAPIRepository(File _image) async {
    try {
      var client = init();
      // upload image to asp.net core server
      var formData = FormData.fromMap({
        "fileToken": await MultipartFile.fromFile(_image.path,
            filename: _image.path.split('/').last),
      });
      print("fom data");
      print(formData);
      final profileResponse = await client.put(
          '/api/services/app/Profile/UpdateProfilePicture',
          data: formData);
      // final _imageBytes = _image.readAsBytesSync();
      // final _imageBase64 = base64UrlEncode(_imageBytes);
      // print("sai ho bo: " + _imageBase64);
      // final profileResponse = await client.put(
      //   '/api/services/app/Profile/UpdateProfilePicture',
      //   data: {"fileToken": _imageBase64},
      // );

      print("duoc k z");
      print(profileResponse.data['result']);

      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}

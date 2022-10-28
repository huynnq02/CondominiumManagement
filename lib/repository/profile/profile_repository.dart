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

  Future<Response> updateProfilePictureAPIRepository(File file) async {
    try {
      var client = init();
      print("zo xxx");
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "fileToken": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      print("toi day");
      print("link ne: " + file.path);
      print("ten ne: " + fileName);
      final profileResponse = await client.put(
        '/api/services/app/Profile/UpdateProfilePicture',
        data: formData,
      );
      print("adu");
      print("repon: " + profileResponse.data);
      return profileResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}

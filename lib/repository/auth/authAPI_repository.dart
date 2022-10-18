import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';
import 'package:untitled/src/models/user.dart';

class AuthAPIRepository extends BaseRepository {
  Future<Response> login({
    required String id,
    required String password,
  }) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/TokenAuth/Authenticate',
        data: {'userNameOrEmailAddress': id, 'password': password},
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> register({MDUser? mdUser,String? otp}) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Account/Register',
        data: {
          "clientType": 1,
          "fullName": mdUser!.fullName,
          "emailAddress": mdUser.email,
          "gender": mdUser.gender,
          "idNumber": mdUser.idNumber,
          "birthDate": mdUser.birthDate,
          "password": mdUser.password,
          "otp": otp
        },
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response?> sendOTP({MDUser? mdUser}) async {
    try {
      var client = init();

      final authRespone = await client.post(
          '/api/services/app/Account/SendEmailActivationOTP',
          data: {
            "clientType": 1,
            "fullName": mdUser!.fullName,
            "emailAddress": mdUser.email,
            "gender": mdUser.gender,
            "idNumber": mdUser.idNumber,
            "birthDate": mdUser.birthDate,
            "password": mdUser.password
          },
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }));

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  // Future<Response> sendEmail({String? email}) async {
  //   try {
  //     var client = init();

  //     final authRespone = await client.post(
  //       '/api/services/app/Account/SendEmailActivationLink',
  //       data: {
  //         "emailAddress": email,
  //       },
  //     );

  //     return authRespone;
  //   } on DioError catch (error) {
  //     return error.response as Response;
  //   }
  // }
}

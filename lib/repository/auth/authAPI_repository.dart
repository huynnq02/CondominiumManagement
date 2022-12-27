import 'dart:developer';
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

  Future<Response> registerWithEmail({MDUser? mdUser}) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Account/RegisterByEmailAddress',
        data: {
          "clientType": 1,
          "fullName": mdUser!.fullName,
          "emailAddress": mdUser.email,
          "gender": mdUser.gender,
          "idNumber": mdUser.idNumber,
          "birthDate": mdUser.birthDate,
          "buildingId": mdUser.buildingId,
          "apartmentId": mdUser.apartmentId,
          "password": mdUser.password,
          "agreeToTermsAndConditions": true,
        },
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response?> sendEmailOTP(String email) async {
    try {
      var client = init();

      final authRespone = await client
          .post('/api/services/app/Account/SendEmailAddressOTP', data: {
        "emailAddress": email,
      });

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response?> confirmEmailOTP(String email, String otp) async {
    try {
      var client = init();

      final authRespone = await client.post(
          '/api/services/app/Account/ConfirmEmailAddressOTP',
          data: {"emailAddress": email, "otp": otp});

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> sendPasswordResetOTP({String? email}) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Account/SendPasswordResetOTP',
        data: {
          "emailAddress": email,
        },
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> checkPasswordResetOTP({String? email, String? otp}) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Account/CheckPasswordResetOTP',
        data: {"emailAddress": email, "otp": otp},
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> resetPassword({String? email, String? password}) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Account/ResetPassword',
        data: {"emailAddress": email, "password": password},
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> resetPasswordWithPhone(
      String phoneNumber, String password) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Account/ResetPasswordWithPhoneNumber',
        data: {"phoneNumber": phoneNumber, "password": password},
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> changePassword({String? currentPw, String? newPw}) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Profile/ChangePassword',
        data: {"currentPassword": currentPw, "newPassword": newPw},
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> checkEmailExistence({String? email}) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Account/EmailAddressIsExist',
        data: {"emailAddress": email},
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> checkPhoneExistence({String? phoneNumber}) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Account/PhoneNumberIsExist',
        data: {"phoneNumber": phoneNumber},
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> registerWithPhone({MDUser? mdUser}) async {
    try {
      var client = init();

      final authRespone = await client.post(
        '/api/services/app/Account/RegisterByPhoneNumber',
        data: {
          "clientType": 1,
          "fullName": mdUser!.fullName,
          "phoneNumber": mdUser.phoneNumber,
          "gender": mdUser.gender,
          "idNumber": mdUser.idNumber,
          "birthDate": mdUser.birthDate,
          "buildingId": mdUser.buildingId,
          "apartmentId": mdUser.apartmentId,
          "password": mdUser.password,
          "agreeToTermsAndConditions": true,
          "emailAddress": ""
        },
      );

      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}

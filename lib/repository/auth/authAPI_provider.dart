import 'package:untitled/repository/auth/authAPI_repository.dart';
import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/src/models/user.dart';

class AuthAPIProvider extends BaseProvider<AuthAPIRepository> {
  @override
  AuthAPIRepository initRepository() {
    return AuthAPIRepository();
  }

  Future login({
    required String id,
    required String password,
  }) async {
    final res = await repository.login(
      id: id,
      password: password,
    );
    return res.data;
  }

  Future registerWithEmail({MDUser? mdUser}) async {
    final res = await repository.registerWithEmail(mdUser: mdUser);
    return res.data;
  }

  Future registerWithPhone({MDUser? mdUser}) async {
    final res = await repository.registerWithPhone(mdUser: mdUser);
    return res.data;
  }

  Future sendEmailOTP(String email) async {
    final res = await repository.sendEmailOTP(email);
    return res?.data;
  }

  Future confirmEmailOTP(String email, String otp) async {
    final res = await repository.confirmEmailOTP(email, otp);
    return res?.data;
  }

  Future sendPasswordResetOTP({String? email}) async {
    final res = await repository.sendPasswordResetOTP(email: email);
    return res.data['success'];
  }

  Future checkPasswordResetOTP({String? email, String? otp}) async {
    final res = await repository.checkPasswordResetOTP(email: email, otp: otp);
    return res.data['result']['otpIsCorrect'];
  }

  Future resetPassword({String? email, String? password}) async {
    final res =
        await repository.resetPassword(email: email, password: password);
    return res.data['success'];
  }

  Future resetPasswordWithPhone(String phoneNumber, String password) async {
    final res = await repository.resetPasswordWithPhone(phoneNumber, password);
    return res.data['success'];
  }

  Future changePassword({String? currentPw, String? newPw}) async {
    final res =
        await repository.changePassword(currentPw: currentPw, newPw: newPw);
    return res.data;
  }

  Future checkEmailExistence({String? email}) async {
    final res = await repository.checkEmailExistence(email: email);
    return res.data['result'];
  }

  Future checkPhoneExistence({String? phoneNumber}) async {
    final res = await repository.checkPhoneExistence(phoneNumber: phoneNumber);
    return res.data['result'];
  }
}

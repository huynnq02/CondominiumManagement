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

  Future register({MDUser? mdUser, String? otp}) async {
    final res = await repository.register(mdUser: mdUser, otp: otp);
    return res.data;
  }

  Future sendOTP({MDUser? mdUser}) async {
    final res = await repository.sendOTP(mdUser: mdUser);
    return res?.data['success'];
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
}

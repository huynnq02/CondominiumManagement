import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/screens/forget%20password%20screen/update_new_password_screen.dart';
import 'package:untitled/src/screens/forget%20password%20screen/update_password_dialog.dart';
import '../../repository/auth/authAPI_provider.dart';

class ResetPasswordProvider extends ChangeNotifier {
  AuthAPIProvider authAPIProvider = AuthAPIProvider();
  String _emailError = '', _otpError = '', _pwError = '';
  bool _isOTPSent = false;

  String get emailError => _emailError;
  set emailError(String value) {
    _emailError = value;
    notifyListeners();
  }

  String get pwError => _pwError;
  set pwError(String value) {
    _pwError = value;
    notifyListeners();
  }

  String get otpError => _otpError;
  set otpError(String value) {
    _otpError = value;
    notifyListeners();
  }

  bool get isOTPSent => _isOTPSent;
  set isOTPSent(bool value) {
    _isOTPSent = value;
    notifyListeners();
  }

  void reset() {
    _isOTPSent = false;
    _emailError = '';
    _otpError = '';
  }

  void resetPwError() {
    _pwError = '';
  }

  Future sendPasswordResetOTP(String email) async {
    var success = await authAPIProvider.sendPasswordResetOTP(email: email);

    // kiểm tra reponse từ api
    if (success == true) {
      isOTPSent = true;
    } else {
      emailError = 'Email không hợp lệ';
    }
  }

  Future checkPasswordResetOTP(
      String email, String otp, BuildContext context) async {
    var success =
        await authAPIProvider.checkPasswordResetOTP(email: email, otp: otp);

    Navigator.of(context).pop();

    // kiểm tra reponse từ api
    if (success == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Xác thực OTP thành công.')));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) =>
              UpdateNewPasswordScreen(isLoggedIn: false, email: email))));
    } else {
      otpError = 'Mã OTP không đúng';
    }
  }

  Future resetPassword(
      String email, String password, BuildContext context) async {
    var success =
        await authAPIProvider.resetPassword(email: email, password: password);

    Navigator.of(context).pop();

    // kiểm tra reponse từ api
    if (success == true) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const UpdatePasswordDialog();
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Đổi mật khẩu thất bại! Hãy kiểm tra lại thông tin.')));
    }
  }

  Future changePassword(
      String currentPw, String newPw, BuildContext context) async {
    var data = await authAPIProvider.changePassword(
        currentPw: currentPw, newPw: newPw);

    // kiểm tra reponse từ api
    if (data['success'] == true) {
      await logOut(context);
      Navigator.of(context).pop();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const UpdatePasswordDialog();
          });
    } else {
      Navigator.of(context).pop();
      pwError = 'Mật khẩu không đúng';
    }
  }

  Future logOut(BuildContext context) async {
    context.read<ProfileProvider>().setEmptyUser();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('token');
  }
}
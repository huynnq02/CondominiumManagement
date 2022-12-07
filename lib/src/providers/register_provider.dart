import 'package:flutter/material.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/screens/register%20screen/register_successful_dialog.dart';

import '../../repository/auth/authAPI_provider.dart';

class RegisterProvider extends ChangeNotifier {
  AuthAPIProvider authAPIProvider = AuthAPIProvider();
  var data;

  String _otpError = '';
  String get otpError => _otpError;
  set otpError(String value) {
    _otpError = value;
    notifyListeners();
  }

  void reset() {
    _otpError = '';
  }

  Future register(MDUser mdUser, String otp, BuildContext context) async {
    data = await authAPIProvider.register(mdUser: mdUser, otp: otp);

    //Dừng trạng thái loading
    Navigator.of(context).pop();

    // kiểm tra reponse từ api
    if (data['success'] == true && data['result']['canLogin'] == true) {
      //đăng kí thành công chuyển về đăng nhập
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const RegisterSuccessfulDialog();
          });
    } else {
      String errMessage = data['error']['message'];
      if (errMessage == 'OTP không đúng!') {
        otpError = errMessage;
      } else {
        // sai thông tin dăng kí thông báo cho người dùng
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Đăng kí thất bại, kiểm tra lại thông tin')));
      }
    }
  }
}

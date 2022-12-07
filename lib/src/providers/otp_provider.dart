import 'package:flutter/material.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/screens/register%20screen/register_otp_screen.dart';

import '../../repository/auth/authAPI_provider.dart';

class OTPProvider extends ChangeNotifier {
  AuthAPIProvider authAPIProvider = AuthAPIProvider();
  var data;

  String _emailError = '';
  String get emailError => _emailError;
  set emailError(String value) {
    _emailError = value;
    notifyListeners();
  }

  void reset() {
    _emailError = '';
  }

  Future sendOTP(MDUser mdUser, BuildContext context) async {
    data = await authAPIProvider.sendOTP(mdUser: mdUser);
    print(data);

    //Dừng trạng thái loading
    Navigator.of(context).pop();

    // kiểm tra reponse từ api
    if (data['success'] == true) {
      //Gửi OTP thành công
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Đã gửi OTP. Hãy kiểm tra hộp thư của bạn.')));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RegisterOTPScreen(mdUser: mdUser),
      ));
    } else {
      String errMessage = data['error']['message'];
      if (errMessage == 'Email đã được người khác đăng ký!') {
        emailError = errMessage;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errMessage)));
      } else {
        // Sai thông tin dăng kí thông báo cho người dùng
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Đăng ký thất bại, kiểm tra lại thông tin')));
      }
    }

    notifyListeners();
  }
}

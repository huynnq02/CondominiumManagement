import 'package:flutter/material.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/screens/register%20screen/confirm_register_screen.dart';

import '../../repository/auth/authAPI_provider.dart';

class OTPProvider extends ChangeNotifier {
  var success;
  AuthAPIProvider authAPIProvider = AuthAPIProvider();
  Future sendOTP(MDUser mdUser, BuildContext context) async {
    success = await authAPIProvider.sendOTP(mdUser: mdUser);

    //Dừng trạng thái loading
    Navigator.of(context).pop();

    // kiểm tra reponse từ api
    if (success == true) {
      //Gửi OTP thành công
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConfirmRegisterScreen(mdUser: mdUser),
      ));
    } else {
      // sai thông tin dăng kí thông báo cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Đăng ký thất bại, kiểm tra lại thông tin')));
    }

    notifyListeners();
  }
}

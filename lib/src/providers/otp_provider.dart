import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/models/user.dart';

import '../../repository/auth/authAPI_provider.dart';

class OTPProvider extends ChangeNotifier {
  var success;
  AuthAPIProvider authAPIProvider = AuthAPIProvider();
  Future<bool> sendOTP(MDUser mdUser, BuildContext context) async {
    success = await authAPIProvider.sendOTP(mdUser: mdUser);
    // kiểm tra reponse từ api
    if (success == true) {
      //Gửi OTP thành công
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gửi OTP thành công')));
    } else {
      // sai thông tin dăng kí thông báo cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Gửi OTP thất bại, kiểm tra lại thông tin')));
    }

    notifyListeners();
    return success;
  }
}

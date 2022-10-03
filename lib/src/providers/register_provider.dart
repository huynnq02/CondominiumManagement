import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/models/user.dart';

import '../../repository/auth/authAPI_provider.dart';
import '../screens/login screen/login_screen.dart';

class RegisterProvider extends ChangeNotifier {
  var success;
  AuthAPIProvider authAPIProvider = AuthAPIProvider();
  Future register(MDUser mdUser, BuildContext context) async {
    success = await authAPIProvider.register(mdUser: mdUser);
    // kiểm tra reponse từ api
    if (success == true) {
      //đăng kí thành công chuyển về đăng nhập
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Đăng kí thành công')));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => LoginScreen())));
    } else {
      // sai thông tin dăng kí thông báo cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Đăng kí thất bại, kiểm tra lại thông tin')));
    }

    notifyListeners();
  }
}

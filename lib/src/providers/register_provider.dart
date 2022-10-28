import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/models/user.dart';

import '../../repository/auth/authAPI_provider.dart';
import '../screens/login screen/login_screen.dart';

class RegisterProvider extends ChangeNotifier {
  var data;
  AuthAPIProvider authAPIProvider = AuthAPIProvider();
  Future register(MDUser mdUser,String otp, BuildContext context) async {
    data = await authAPIProvider.register(mdUser: mdUser,otp: otp);

    //Dừng trạng thái loading
    Navigator.of(context).pop();
    
    // kiểm tra reponse từ api
    if (data['success'] == true && data['result']['canLogin']==true) {
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

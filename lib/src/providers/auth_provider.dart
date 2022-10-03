import 'package:flutter/cupertino.dart';
import 'package:untitled/repository/auth/authAPI_provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  var status;
  var data;
  var success;
  var accessToken;
  var message;
  var userId;
  //Xử lý login
  Future login({
    required String id,
    required String password,
  }) async {
    data = await AuthAPIProvider().login(id: id, password: password);

    success = data['success'];
    // kiểm tra reponse từ api để xử lý đăng nhập
    if (success == false) {
      message = data['error']['message'];
      message == 'Invalid user name or password'
          ? message = 'Sai thông tin đăng nhập.'
          : message ==
                  'The user account has been locked out. Please try again later.'
              ? message =
                  'Tài khoản người dùng đã bị khóa. Vui lòng thử lại sau.'
              : message;
      print(message);
    } else {
      message = 'Loading';
      accessToken = data['result']['accessToken'];
      userId = data['result']['userId'];
    }
  }
}

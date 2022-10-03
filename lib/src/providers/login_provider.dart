import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/auth_provider.dart';
import 'package:untitled/src/screens/main%20screen/main_screen.dart';
import 'package:untitled/utils/helper/app_preference.dart';

class LoginProvider extends ChangeNotifier {
  AuthenticationProvider? authAPIProvider;
  bool check = false;
  bool? checkSavePro = false;
  String? email;
  String? password;
  String? getToken;
  String? userId;
//Lưu dữ liệu vào sharePreference
  setPreference(String valueEmail, String valuePassword) async {
    await AppPreferences.prefs.setString('email', valueEmail);
    await AppPreferences.prefs.setString('password', valuePassword);
  }

  setPreferenceToken(String token, String userId) async {
    await AppPreferences.prefs.setString('token', token);
    await AppPreferences.prefs.setString('userId', userId);
  }

//Kiểm tra tài khoản khi đăng nhập
  Future<void> checkAccount(String valueEmail, String valuePassword,
      bool? checkSave, BuildContext context) async {
    authAPIProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    await authAPIProvider!
        .login(id: valueEmail.toString(), password: valuePassword.toString());
    check = authAPIProvider!.success;

    var message = authAPIProvider!.message;
    //check nút lưu thông tin
    checkSavePro = checkSave!;

    // check thông tin đăng nhập
    check == true
        ? setPreferenceToken(authAPIProvider!.accessToken,
            authAPIProvider!.userId.toString()) // lưu token vào sharePreference
        : '';
    setPreference(valueEmail, valuePassword);
    check == true
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreen(
                      checkScreen: true,
                    )))
        : ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message == null ? '' : message)));
  }

// lấy email, password từ SharePreference
  void getEmailPassword() {
    email = AppPreferences.prefs.getString('email');
    password = AppPreferences.prefs.getString('password');
  }

// check nút lưu thông tin
  void checkSave() {
    checkSavePro = AppPreferences.prefs.getBool('save');

    checkSavePro == true ? getEmailPassword() : '';
  }

  void checkToken() async {
    getToken = AppPreferences.prefs.getString('token');

    getToken != null ? check = true : check = false;
  }

// kiểm tra nút lưu để hiển thị, khi lưu thông tin đăng nhập
  void setAccount(
      {required bool checkBox,
      required String value,
      required TextEditingController controller}) {
    checkBox == false || value == 'null'
        ? controller
        : value != 'null'
            ? controller.text = value.toString()
            : controller;
  }

// Kiểm tra lại tài khoản cập nhật token mới
  Future<void> checkAccountMain(
      String valueEmail, String valuePassword, BuildContext context) async {
    authAPIProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    await authAPIProvider!
        .login(id: valueEmail.toString(), password: valuePassword.toString());

    check == true
        ? setPreferenceToken(
            authAPIProvider!.accessToken, authAPIProvider!.userId.toString())
        : null;
  }
}

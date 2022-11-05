// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/screens/forget%20password%20screen/forget_password_screen.dart';
import 'package:untitled/src/screens/login%20screen/widget/email_textfield.dart';
import 'package:untitled/src/screens/login%20screen/widget/password_textfield.dart';
import 'package:untitled/src/screens/register%20screen/register_screen.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import '../../../utils/app_constant/app_colors.dart';
import '../../../utils/helper/app_preference.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? valueEmail;
  String? valuePassword;
  bool checkSave = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginProvider? loginProvider;
  @override
  void initState() {
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider!.checkSave();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox.expand(
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/login-screen-background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      child: Image.asset('assets/apato-logo.png'),
                      top: height * 0.23),
                  Padding(
                    padding: const EdgeInsets.only(left: 21, right: 10),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: height,
                        child: Column(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Stack(
                                children: [
                                  Text(
                                    "Đăng nhập",
                                    style: AppTextStyle.tomorrow.copyWith(
                                      fontSize: 48,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 1
                                        ..color = AppColors.Black,
                                    ),
                                  ),
                                  Text(
                                    "Đăng nhập",
                                    style: AppTextStyle.tomorrow.copyWith(
                                      fontSize: 48,
                                      color: AppColors.White,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.07),
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.05),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    EmailTextField(
                                      check: loginProvider!.checkSavePro ==
                                              null //kiểm tra nút lưu có được chọn để hiển thị email
                                          ? false
                                          : loginProvider!.checkSavePro!,
                                      valueEmail:
                                          loginProvider!.email.toString(),
                                      email: (val) => (valueEmail = val),
                                    ),
                                    PasswordTextField(
                                      check: loginProvider!.checkSavePro ==
                                              null //kiểm tra nút lưu có được chọn để hiển thị password
                                          ? false
                                          : loginProvider!.checkSavePro!,
                                      valuePassword:
                                          loginProvider!.password.toString(),
                                      password: (val) => (valuePassword = val),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: height * 0.06,
                                        width: width * 0.43,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            primary: AppColors.White,
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              AppPreferences.prefs.setBool(
                                                  'save',
                                                  checkSave); //lưu trạng thái của nút lưu thông tin

                                              //Hiển thị trạng thái loading
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  });

                                              loginProvider!.checkAccount(
                                                  // kiểm tra đăng nhập
                                                  valueEmail.toString() +
                                                      '@gmail.com',
                                                  valuePassword.toString(),
                                                  checkSave,
                                                  context);
                                            }
                                          },
                                          child: Text(
                                            'Đăng nhập',
                                            style:
                                                AppTextStyle.lexendExa.copyWith(
                                              color: AppColors.Black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.025),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      ForgetPasswordScreen())));
                                        },
                                        child: Text(
                                          "Quên mật khẩu",
                                          style: AppTextStyle.lato.copyWith(
                                              color: Color(0xFF4200FF),
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(height: height * 0.15),
                                    Spacer(),
                                    Container(
                                      // height: height * 0.09,
                                      width: width * 0.6,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColors.White),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Không có tài khoản?",
                                            style: AppTextStyle.nunitoSize13
                                                .copyWith(
                                              fontSize: 20,
                                              color: Color(0xFFFFFFFF)
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          RegisterScreen())));
                                            },
                                            child: Stack(
                                              children: [
                                                Text(
                                                  "Đăng kí",
                                                  style: AppTextStyle.tomorrow
                                                      .copyWith(
                                                    fontSize: 28,
                                                    foreground: Paint()
                                                      ..style =
                                                          PaintingStyle.stroke
                                                      ..strokeWidth = 2
                                                      ..color =
                                                          Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                Text(
                                                  "Đăng kí",
                                                  style: AppTextStyle.tomorrow
                                                      .copyWith(
                                                    fontSize: 28,
                                                    color: Color(0xFFFA00FF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Spacer(),
                                    const SizedBox(height: 44),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Image.asset('assets/city.png')),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

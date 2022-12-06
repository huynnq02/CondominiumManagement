// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/screens/forget%20password%20screen/forget_password_screen.dart';
import 'package:untitled/src/screens/register%20screen/register_screen.dart';
import 'package:untitled/src/widget/register_textfield.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import '../../../utils/app_constant/app_colors.dart';
import '../../../utils/helper/app_preference.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: _formKey, 
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   image:
                        //       AssetImage('assets/login-screen-background.png'),
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 29),
                      Image.asset(
                        'assets/apato-logo-darker.png',
                        width: width * 0.35,
                      ),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Column(
                                children: [
                                  // SizedBox(height: height * 0.07),
                                  // EmailTextField(
                                  //   check: loginProvider!.checkSavePro ==
                                  //           null //kiểm tra nút lưu có được chọn để hiển thị email
                                  //       ? false
                                  //       : loginProvider!.checkSavePro!,
                                  //   valueEmail:
                                  //       loginProvider!.email.toString(),
                                  //   email: (val) => (valueEmail = val),
                                  // ),
                                  // PasswordTextField(
                                  //   check: loginProvider!.checkSavePro ==
                                  //           null //kiểm tra nút lưu có được chọn để hiển thị password
                                  //       ? false
                                  //       : loginProvider!.checkSavePro!,
                                  //   valuePassword:
                                  //       loginProvider!.password.toString(),
                                  //   password: (val) =>
                                  //       (valuePassword = val),
                                  // ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                      color: Colors.white
                                    ),
                                    child: Column(
                                      children: [
                                        RegisterTextField(
                                          labelText: 'Email/ Số điện thoại',
                                          controller: emailController,
                                          type: TextFieldType.email,
                                          border: const BorderRadius.only(
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(12.0),
                                          ),
                                        ),
                                        RegisterTextField(
                                          labelText: 'Mật khẩu',
                                          controller: passwordController,
                                          type: TextFieldType.password,
                                          border: const BorderRadius.only(
                                            bottomLeft: Radius.circular(12.0),
                                            bottomRight: Radius.circular(12.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  SizedBox(
                                    height: 48,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          backgroundColor: AppColors.DarkBlue,
                                          elevation: 4),
                                      onPressed: () {
                                        setState(() {});
                                        if (_formKey.currentState!.validate()) {
                                          AppPreferences.prefs.setBool('save',
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
                                              emailController.text,
                                              passwordController.text,
                                              checkSave,
                                              context);
                                        }
                                      },
                                      child: Text(
                                        'Đăng nhập',
                                        style: AppTextStyle.lexendExa.copyWith(
                                          color: AppColors.White,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 22),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    ForgetPasswordScreen())));
                                      },
                                      child: Text(
                                        "Quên mật khẩu ?",
                                        style: TextStyle(
                                            color: AppColors.DarkBlue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: height * 0.15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Chưa có tài khoản?",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => RegisterScreen())));
                            },
                            child: Text(
                              "Đăng ký tại đây",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.DarkBlue,
                                  fontWeight: FontWeight.w300),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 13),
                      Image.asset('assets/city.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/screens/forget%20password%20screen/forget_password_screen.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_button.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_textfield.dart';
import 'package:untitled/src/screens/register%20screen/register_screen.dart';
import 'package:untitled/utils/helper/app_preference.dart';
import '../../../utils/app_constant/app_colors.dart';

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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.White,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Form(
            key: _formKey,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 35, vertical: height * 0.03),
                child: Column(
                  children: [
                    const Text(
                      'Đăng nhập',
                      style: TextStyle(
                          color: Color(0xFF58583A),
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: height * 0.036,
                    ),
                    Image.asset(
                      'assets/apato-logo-light-blue.png',
                      width: width * 0.34,
                    ),
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email/ Số điện thoại',
                      type: TextFieldType.email,
                      maxLength: 50,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      labelText: 'Mật khẩu',
                      type: TextFieldType.password,
                      maxLength: 20,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CustomButton(
                      label: 'Đăng nhập',
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
                                  child: CircularProgressIndicator(),
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
                    ),
                    SizedBox(height: height * 0.03),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => ForgetPasswordScreen())));
                      },
                      child: Text(
                        "Quên mật khẩu ?",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Chưa có tài khoản? ',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => RegisterScreen())));
                        },
                        label: 'Đăng ký'),
                    SizedBox(
                      height: height * 0.02,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

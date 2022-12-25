// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0xFF323232),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        content: Text(
          'Chức năng đang được phát triển, vui lòng truy cập lại sau!',
          style: TextStyle(fontSize: 13, color: Colors.white),
          textAlign: TextAlign.center,
        )));
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
                    horizontal: 35, vertical: height * 0.047),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/apato-logo-light-blue.png',
                      width: width * 0.34,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                        child: CircularProgressIndicator(
                                          color: AppColors.DarkPink,
                                        ),
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
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) =>
                                      ForgetPasswordScreen())));
                            },
                            child: Text(
                              "Quên mật khẩu?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Chưa có tài khoản? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 16),
                            ),
                            SizedBox(width: 7),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => RegisterScreen())));
                              },
                              child: Text(
                                'Đăng ký',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.DarkPink,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        const Text(
                          'Hoặc tiếp tục với',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xFF7D8387)),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () => showSnackBar(),
                                child: SvgPicture.asset(
                                    'assets/facebook-btn.svg')),
                            SizedBox(
                              width: width * 0.07,
                            ),
                            InkWell(
                                onTap: () => showSnackBar(),
                                child: SvgPicture.asset('assets/google.svg')),
                            SizedBox(
                              width: width * 0.07,
                            ),
                            InkWell(
                                onTap: () => showSnackBar(),
                                child: SvgPicture.asset(
                                    'assets/apple.svg')), /*  */
                          ],
                        ),
                      ],
                    ),
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

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/screens/login%20screen/widget/checkbox.dart';
import 'package:untitled/src/screens/login%20screen/widget/email_textfield.dart';
import 'package:untitled/src/screens/login%20screen/widget/password_textfield.dart';
import 'package:untitled/src/screens/register%20screen/register_screen.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import '../../../utils/app_constant/app_colors.dart';
import '../../../utils/helper/app_preference.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SizedBox.expand(
            child: Form(
              key: _formKey,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: FractionallySizedBox(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.6,
                        child: Image.asset('assets/header.png'),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Image.asset('assets/city.png'),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              EmailTextField(
                                check: loginProvider!.checkSavePro ==
                                        null //kiểm tra nút lưu có được chọn để hiển thị email
                                    ? false
                                    : loginProvider!.checkSavePro!,
                                valueEmail: loginProvider!.email.toString(),
                                email: (val) => (valueEmail = val),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              PasswordTextField(
                                  check: loginProvider!.checkSavePro ==
                                          null //kiểm tra nút lưu có được chọn để hiển thị password
                                      ? false
                                      : loginProvider!.checkSavePro!,
                                  valuePassword:
                                      loginProvider!.password.toString(),
                                  password: (val) => (valuePassword = val)),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Align(
                              //       child: CustomCheckBox(
                              //         check: checkSave,
                              //         checkSave: (val) => checkSave =
                              //             val, // lấy dữ liệu trả về từ widget child
                              //       ),
                              //       alignment: Alignment.centerLeft,
                              //     ),
                              //     // TextButton(
                              //     //     onPressed: () {
                              //     //       Navigator.of(context).push(
                              //     //           MaterialPageRoute(builder: ((context) {
                              //     //         return ForgetPasswordScreen();
                              //     //       })));
                              //     //     },
                              //     //     child: Text(
                              //     //       'Quên mật khẩu',
                              //     //       style: AppTextStyle.nunitoSize13,
                              //     //     ))
                              //   ],
                              // ),
                              Stack(
                                fit: StackFit.loose,
                                alignment: Alignment.center,
                                children: [
                                  Image.asset('assets/cover-button-login.png'),
                                  SizedBox(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.ButtonLoginColor,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          AppPreferences.prefs.setBool('save',
                                              checkSave); //lưu trạng thái của nút lưu thông tin
                                          loginProvider!.checkAccount(
                                              // kiểm tra đăng nhập
                                              valueEmail.toString(),
                                              valuePassword.toString(),
                                              checkSave,
                                              context);
                                        }
                                      },
                                      child: Text(
                                        'Đăng nhập',
                                        style: AppTextStyle.nunitoSize13
                                            .copyWith(
                                                color: AppColors.Black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       'Chưa có tài khoản! ',
                              //       style: AppTextStyle.nunitoBoldSize14
                              //           .copyWith(fontSize: 12),
                              //     ),
                              //     TextButton(
                              //       onPressed: () {
                              //         Navigator.of(context).push(
                              //           MaterialPageRoute(
                              //             builder: ((context) {
                              //               return RegisterScreen();
                              //             }),
                              //           ),
                              //         );
                              //       },
                              //       child: InkWell(
                              //         onTap: () => {},
                              //         child: Text(
                              //           'Đăng kí',
                              //           style: AppTextStyle.nunitoBoldSize14
                              //               .copyWith(
                              //                   fontSize: 12,
                              //                   color: AppColors.Blue),
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),
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
      ),
    );
  }
}

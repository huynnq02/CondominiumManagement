// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/screens/login%20screen/widget/checkbox.dart';
import 'package:untitled/src/screens/login%20screen/widget/email_textfield.dart';
import 'package:untitled/src/screens/login%20screen/widget/password_textfield.dart';
import 'package:untitled/src/screens/logout%20screen/logout_screen.dart';
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
                  // Container(
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(

                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   bottom: 0,
                  //   child: Image.asset('assets/city.png'),
                  // ),

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
                              child: Text(
                                "Đăng nhập",
                                style: AppTextStyle.tomorrow
                                    .copyWith(fontSize: 25),
                              ),
                            ),
                            SizedBox(height: height * 0.1),
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

                                              loginProvider!.checkAccount(
                                                  // kiểm tra đăng nhập
                                                  valueEmail.toString(),
                                                  valuePassword.toString(),
                                                  checkSave,
                                                  context);
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         const LogoutTemp(),
                                              //   ),
                                              // );
                                            }
                                          },
                                          child: Text(
                                            'Đăng nhập',
                                            style: AppTextStyle.nunitoSize13
                                                .copyWith(
                                              color: AppColors.Black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.025),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Quên mật khẩu",
                                        style: AppTextStyle.lato.copyWith(
                                            color: Color(0xFF4200FF),
                                            fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.15),
                                    Container(
                                      height: height * 0.07,
                                      width: width * 0.55,
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
                                              fontSize: 12,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => {print("Tapped")},
                                            child: Text(
                                              "Đăng kí",
                                              style: AppTextStyle
                                                  .nunitoBoldSize14
                                                  .copyWith(
                                                fontSize: 13,
                                                color: Color(0xFFFA00FF),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: height * 0.08),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Image.asset('assets/city.png')),
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
                                    // TextButton(
                                    //     onPressed: () {
                                    //       Navigator.of(context).push(
                                    //           MaterialPageRoute(builder: ((context) {
                                    //         return ForgetPasswordScreen();
                                    //       })));
                                    //     },
                                    //     child: Text(
                                    //       'Quên mật khẩu',
                                    //       style: AppTextStyle.nunitoSize13,
                                    //     ))
                                    //   ],
                                    // ),
                                    // Stack(
                                    //   fit: StackFit.loose,
                                    //   alignment: Alignment.center,
                                    //   children: [
                                    //     Image.asset(
                                    //         'assets/cover-button-login.png'),
                                    //     SizedBox(
                                    //       child: ElevatedButton(
                                    //         style: ElevatedButton.styleFrom(
                                    //           primary:
                                    //               AppColors.ButtonLoginColor,
                                    //         ),
                                    //         onPressed: () {
                                    //           if (_formKey.currentState!
                                    //               .validate()) {
                                    //             AppPreferences.prefs.setBool(
                                    //                 'save',
                                    //                 checkSave); //lưu trạng thái của nút lưu thông tin
                                    //             loginProvider!.checkAccount(
                                    //                 // kiểm tra đăng nhập
                                    //                 valueEmail.toString(),
                                    //                 valuePassword.toString(),
                                    //                 checkSave,
                                    //                 context);
                                    //             Navigator.push(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                   builder: (context) =>
                                    //                       const LogoutTemp()),
                                    //             );
                                    //           }
                                    //         },
                                    //         child: Text(
                                    //           'Đăng nhập',
                                    //           style: AppTextStyle.nunitoSize13
                                    //               .copyWith(
                                    //                   color: AppColors.Black,
                                    //                   fontSize: 20,
                                    //                   fontWeight:
                                    //                       FontWeight.bold),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
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

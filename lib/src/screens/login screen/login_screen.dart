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
        body: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox.expand(
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 148,
                          ),
                          Image.asset('assets/logo.png'),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            'Đăng Nhập Hệ Thống',
                            style: AppTextStyle.nunitoSize13
                                .copyWith(fontSize: 18, color: AppColors.Blue),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: EmailTextField(
                                check: loginProvider!.checkSavePro ==
                                        null //kiểm tra nút lưu có được chọn để hiển thị email
                                    ? false
                                    : loginProvider!.checkSavePro!,
                                valueEmail: loginProvider!.email.toString(),
                                email: (val) => (valueEmail = val)),
                          ),
                          PasswordTextField(
                              check: loginProvider!.checkSavePro ==
                                      null //kiểm tra nút lưu có được chọn để hiển thị password
                                  ? false
                                  : loginProvider!.checkSavePro!,
                              valuePassword: loginProvider!.password.toString(),
                              password: (val) => (valuePassword = val)),
                          SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                child: CustomCheckBox(
                                  check: checkSave,
                                  checkSave: (val) => checkSave =
                                      val, // lấy dữ liệu trả về từ widget child
                                ),
                                alignment: Alignment.centerLeft,
                              ),
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
                            ],
                          ),
                          SizedBox(
                            height: 21,
                          ),
                          SizedBox(
                            width: 382,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColors.Blue),
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
                                style: AppTextStyle.nunitoSize13.copyWith(
                                    color: AppColors.White,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Chưa có tài khoản! ',
                      style:
                          AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 12),
                    ),
                    TextButton(
                        // onPressed: () {
                        //   Navigator.of(context)
                        //       .push(MaterialPageRoute(builder: ((context) {
                        //     return RegisterScreen();
                        //   })));
                        // },
                        onPressed: () => showLogoutConfirmPopupDialog(
                            context, height, width),
                        child: Text('Đăng kí',
                            style: AppTextStyle.nunitoBoldSize14
                                .copyWith(fontSize: 12, color: AppColors.Blue)))
                  ],
                ),
                Image.asset('assets/slide2.png')
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void showLogoutConfirmPopupDialog(BuildContext context, height, width) =>
      showDialog(
        context: context,
        builder: ((context) => Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                height: height * 0.18,
                width: width * 0.8,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 17, left: 8, right: 8),
                    child: Column(
                      children: [
                        const Text(
                          "Bạn có chắc chắn không?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.023,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.LogoutButtonColor,
                                fixedSize: Size(
                                  width * 0.25,
                                  height * 0.04,
                                ),
                                // minimumSize: Size(width * 0.2, height * 0.035),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                ),
                              ),
                              child: Text(
                                "Đăng xuất",
                                style: TextStyle(
                                    color: AppColors.White, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.08,
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.Black,
                                fixedSize: Size(
                                  width * 0.25,
                                  height * 0.04,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                ),
                              ),
                              child: Text(
                                "Hủy",
                                style: TextStyle(
                                    color: AppColors.White, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      );
}

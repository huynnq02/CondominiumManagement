import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/register_provider.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';
import 'package:untitled/src/screens/register%20screen/confirm_register_screen.dart';

import '../../../utils/app_constant/app_colors.dart';
import '../../../utils/app_constant/app_text_style.dart';
import '../../widget/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterProvider? provider;
  MDUser mdUser = MDUser();
  String? password;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<RegisterProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: AppColors.White,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 57,
              ),
              Image.asset(
                'assets/logo.png',
                width: 328,
                height: 81,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Đăng Ký Tài Khoản Mới',
                      style: AppTextStyle.nunitoSize13.copyWith(
                          color: AppColors.Blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        input: 'Nhập họ và tên của bạn',
                        type: iconType.person,
                        valueString: (value) => mdUser.name = value),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomTextField(
                      input: 'Điền email của bạn...',
                      type: iconType.mail,
                      valueString: (value) => mdUser.email = value,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomTextField(
                      input: 'Nhập mật khẩu...',
                      type: iconType.lock,
                      valueString: (value) => mdUser.password = value,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomTextField(
                        input: 'Nhập lại mật khẩu...',
                        type: iconType.lock,
                        valueString: (value) => password = value),
                    const SizedBox(
                      height: 18,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: 382,
                      height: 56,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: AppColors.Blue),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (password == mdUser.password) {
                              provider!.register(mdUser, context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Mật khẩu không hợp lệ')));
                            }
                          }
                        },
                        child: Text(
                          'Đăng ký',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Đã có tài khoản! ',
                    style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 12),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) {
                          return LoginScreen();
                        })));
                      },
                      child: Text('Đăng nhập',
                          style: AppTextStyle.nunitoBoldSize14
                              .copyWith(fontSize: 12, color: AppColors.Blue)))
                ],
              ),
              Image.asset('assets/slide2.png')
            ],
          ),
        ),
      ),
    )));
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';

import '../../../utils/app_constant/app_colors.dart';
import '../../../utils/app_constant/app_text_style.dart';
import '../../widget/custom_textfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: AppColors.White,
        child: Form(
          key: _formKey,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Quên Mật Khẩu',
                        style: AppTextStyle.nunitoSize13.copyWith(
                            color: AppColors.Blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const CustomTextField(
                        input: 'Điền email của bạn...',
                        type: iconType.mail,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Quay lại ',
                            style: AppTextStyle.nunitoBoldSize14
                                .copyWith(fontSize: 12),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: ((context) {
                                  return LoginScreen();
                                })));
                              },
                              child: Text(
                                'Đăng nhập',
                                style: AppTextStyle.nunitoBoldSize14.copyWith(
                                    fontSize: 12, color: AppColors.Blue),
                              ))
                        ],
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
                            print('tap ');
                          },
                          child: Text(
                            'Quên mật khẩu',
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
              Image.asset('assets/slide2.png')
            ],
          ),
        ),
      ),
    ));
  }
}

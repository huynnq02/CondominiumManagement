import 'package:flutter/material.dart';

import '../../../utils/app_constant/app_colors.dart';
import '../../../utils/app_constant/app_text_style.dart';
import '../../widget/custom_textfield.dart';

class UpdateNewPasswordScreen extends StatelessWidget {
  const UpdateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.White,
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
                        'Cập Nhật Mật Khẩu Mới',
                        style: AppTextStyle.nunitoSize13.copyWith(
                            color: AppColors.Blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const CustomTextField(
                        input: 'Nhập mật khẩu mới...',
                        type: iconType.lock,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const CustomTextField(
                        input: 'Nhập lại mật khẩu mới...',
                        type: iconType.lock,
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
                            'Cập nhật',
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
    );
  }
}

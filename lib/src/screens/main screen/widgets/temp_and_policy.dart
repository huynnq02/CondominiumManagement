import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../../utils/app_constant/app_text_style.dart';

class TempAndPolicy extends StatelessWidget {
  const TempAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Điều khoản',
                style: AppTextStyle.nunitoSize13.copyWith(
                    fontSize: 18,
                    color: AppColors.LightBlue1,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Giới thiệu',
                style: AppTextStyle.nunitoSize13,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Chính sách bảo mật',
                style: AppTextStyle.nunitoSize13,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Điều kiện giao dịch',
                style: AppTextStyle.nunitoSize13,
              ),
            ],
          ),
          const SizedBox(
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hướng dẫn',
                style: AppTextStyle.nunitoSize13.copyWith(
                    color: AppColors.LightBlue1,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('Hướng dẫn sử dụng', style: AppTextStyle.nunitoSize13),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Thông tin góp ý',
                style: AppTextStyle.nunitoSize13,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

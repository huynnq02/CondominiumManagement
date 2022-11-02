import 'package:flutter/material.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';

class UserInfo extends StatelessWidget {
  final String info;
  final String value;
  const UserInfo({
    Key? key,
    required this.info,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color(0x00000033).withOpacity(0.20), width: 1),
        color: AppColors.White,
        boxShadow: const [
          BoxShadow(
            color: AppColors.Grey,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              info,
              style: AppTextStyle.lato.copyWith(fontSize: 16),
            ),
            Text(
              value,
              style: AppTextStyle.lato.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

Row CustomRichTextPayment(String title, String data, double fontSize) {
  return Row(
    children: [
      Text(
        title,
        style: AppTextStyle.lato.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        data,
        style: AppTextStyle.lato.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: AppColors.Red,
        ),
      )
    ],
  );
}

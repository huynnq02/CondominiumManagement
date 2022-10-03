// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class PageCounter extends StatelessWidget {
  const PageCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 15, bottom: 15),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(color: AppColors.DarkGrey, width: 0.5),
          ),
          child: Text(
            '1/4',
            style: AppTextStyle.nunitoBoldSize14
                .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

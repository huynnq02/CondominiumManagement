// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../models/phone.dart';

class CustomProgressBar extends StatelessWidget {
  Phone phone;
  CustomProgressBar({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const width = 67.0;
    double widthRate = phone.statistical!.overallScore != null
        ? double.parse(phone.statistical!.overallScore.toString()) * 10
        : 0;
    return SizedBox(
      height: 15,
      width: width,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.LightGrey,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          Container(
            width: width * widthRate / 100,
            decoration: BoxDecoration(
              color: double.parse(phone.statistical!.overallScore.toString()) <
                      7
                  ? AppColors.Yellow
                  : double.parse(phone.statistical!.overallScore.toString()) < 5
                      ? AppColors.Red
                      : AppColors.Green,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

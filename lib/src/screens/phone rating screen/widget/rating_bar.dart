// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class RatingBar extends StatelessWidget {
  double rate;
  RatingBar({Key? key, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const width = 300.0;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 12,
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
                  width: rate > 0 ? width * (rate * 10) / 100 : 0,
                  decoration: BoxDecoration(
                    color: AppColors.LightBlue1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            rate > 0 ? rate.toString() : '0',
            style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 16),
          )
        ],
      ),
    );
  }
}

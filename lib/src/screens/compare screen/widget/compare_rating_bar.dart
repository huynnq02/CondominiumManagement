// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ComapreRatingBar extends StatelessWidget {
  final double rate;
  const ComapreRatingBar({Key? key, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 12,
            width: size.width / 3,
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
                  width: rate != -1 ? (size.width / 3) * (rate * 10) / 100 : 0,
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
          SizedBox(width: 4),
          Text(
            rate != -1 ? rate.toString() : 0.toString(),
            style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}

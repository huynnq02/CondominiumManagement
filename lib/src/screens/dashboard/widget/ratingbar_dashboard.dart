// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class RatingBarDashboard extends StatelessWidget {
  final double rate;
  final Color colors;
  const RatingBarDashboard({Key? key, required this.colors, required this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = 130.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
                width: width * (rate * 10) / 100,
                decoration: BoxDecoration(
                  color: colors,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

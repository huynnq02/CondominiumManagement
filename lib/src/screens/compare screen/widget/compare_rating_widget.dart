// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/rating_bar.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import 'compare_rating_bar.dart';

class CompareRatingWidget extends StatelessWidget {
  final double rate;
  final typeOfRate;
  const CompareRatingWidget(
      {Key? key, required this.rate, required this.typeOfRate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComapreRatingBar(rate: rate),
        Text(
          typeOfRate.toString(),
          style: AppTextStyle.nunitoSize13.copyWith(
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 7,
        ),
      ],
    );
  }
}

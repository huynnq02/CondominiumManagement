// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class CompareCSIDetail extends StatelessWidget {
  const CompareCSIDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                'assets/smiley-face.svg',
                height: 13,
                width: 13,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                '160',
                style:
                    AppTextStyle.nunitoSize13.copyWith(color: AppColors.Orange),
              ),
              VerticalDivider(
                color: AppColors.Grey,
                thickness: 2,
              ),
              SvgPicture.asset(
                'assets/sad-face.svg',
                height: 13,
                width: 13,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                '38',
                style: AppTextStyle.nunitoSize13
                    .copyWith(color: AppColors.DarkGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

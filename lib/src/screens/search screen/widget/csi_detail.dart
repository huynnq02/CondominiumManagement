// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/src/models/statistical.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class CSIDetail extends StatelessWidget {
  final Statistical? statistical;
  const CSIDetail({Key? key, required this.statistical}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: SvgPicture.asset(
                'assets/smiley-face.svg',
                height: 25,
                width: 25,
              )),
              SizedBox(
                width: 3,
              ),
              Expanded(
                  child: Text(
                statistical != null
                    ? statistical!.totalPositive.toString()
                    : '0',
                style: AppTextStyle.nunitoBoldSize14
                    .copyWith(color: AppColors.Orange, fontSize: 13),
              )),
              VerticalDivider(
                color: AppColors.Grey,
                thickness: 2,
              ),
              Expanded(
                  child: SvgPicture.asset(
                'assets/sad-face.svg',
                height: 25,
                width: 25,
              )),
              SizedBox(
                width: 3,
              ),
              Expanded(
                  child: Text(
                statistical != null
                    ? statistical!.totalNegative.toString()
                    : '0',
                style: AppTextStyle.nunitoBoldSize14
                    .copyWith(color: AppColors.DarkGrey, fontSize: 13),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

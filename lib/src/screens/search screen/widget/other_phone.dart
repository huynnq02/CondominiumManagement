// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/src/screens/search%20screen/widget/custom_gridview.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../../utils/app_constant/app_colors.dart';

class OtherPhone extends StatelessWidget {
  const OtherPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.LightBlue1,
            spreadRadius: -5,
            blurRadius: 4,
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Các sản phẩm được đánh giá cao',
                style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              CustomGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class CustomHardwareRow extends StatelessWidget {
  final index;
  final component;
  final nameOfComponent;
  const CustomHardwareRow(
      {Key? key,
      required this.component,
      required this.nameOfComponent,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      color: (index % 2) == 0 ? AppColors.LightGrey1 : AppColors.White,
      child: Row(
        children: [
          Container(
            width: 150,
            child: Text(
              component,
              style: AppTextStyle.robotoSize14
                  .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                nameOfComponent,
                style: AppTextStyle.nunitoBoldSize14
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          )
        ],
      ),
    );
  }
}

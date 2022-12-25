import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../../utils/app_constant/app_text_style.dart';

class BillRowInfo extends StatelessWidget {
  final String name;
  final String value;
  final double? topRadius, bottomRadius;
  final double bottomBorder, topBorder;
  const BillRowInfo({
    Key? key,
    required this.name,
    required this.value,
    this.topRadius,
    this.bottomRadius,
    required this.bottomBorder,
    required this.topBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius ?? 0),
          topRight: Radius.circular(topRadius ?? 0),
          bottomLeft: Radius.circular(bottomRadius ?? 0),
          bottomRight: Radius.circular(bottomRadius ?? 0),
        ),
        border: Border(
          top: BorderSide(
            color: const Color(0xFFD9D9D9),
            width: topBorder,
          ),
          bottom: BorderSide(
            color: const Color(0xFFD9D9D9),
            width: bottomBorder,
          ),
          left: const BorderSide(
            color: Color(0xFFD9D9D9),
            width: 1,
          ),
          right: const BorderSide(
            color: Color(0xFFD9D9D9),
            width: 1,
          ),
        ),
        color: const Color(0xFFFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Text(
              name,
              style: AppTextStyle.lato.copyWith(
                  fontSize: 16,
                  color: AppColors.Black,
                  fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Text(
              value,
              style: AppTextStyle.lato
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

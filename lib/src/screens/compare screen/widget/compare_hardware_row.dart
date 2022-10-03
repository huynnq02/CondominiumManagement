import 'package:flutter/material.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';

class CompareHardwareRow extends StatelessWidget {
  final index;
  final component;
  final nameOfComponent;
  const CompareHardwareRow(
      {Key? key,
      required this.component,
      required this.nameOfComponent,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      color: AppColors.White,
      child: Row(
        children: [
          Container(
              width: 140,
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: component,
                        style: AppTextStyle.robotoSize14.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: " " + nameOfComponent,
                      style: AppTextStyle.robotoSize14.copyWith(fontSize: 14),
                    )
                  ],
                ),
              )),

        ],
      ),
    );
  }
}

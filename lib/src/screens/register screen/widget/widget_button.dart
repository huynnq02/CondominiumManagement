import 'package:flutter/material.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';

class WidgetButton extends StatefulWidget {
  WidgetButton({Key? key}) : super(key: key);

  @override
  State<WidgetButton> createState() => _WidgetButtonState();
}

class _WidgetButtonState extends State<WidgetButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          minWidth: 160,
          height: 45,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: AppColors.Red)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Hủy bỏ',
            style: AppTextStyle.nunitoSize13.copyWith(
                color: AppColors.Red,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        MaterialButton(
          height: 45,
          minWidth: 160,
          color: AppColors.Blue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: AppColors.Blue)),
          onPressed: () {},
          child: Text(
            'Cập nhật',
            style: AppTextStyle.nunitoSize13.copyWith(
                color: AppColors.White,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

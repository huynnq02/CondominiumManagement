import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../../utils/helper/app_preference.dart';

class CustomCheckBox extends StatefulWidget {
  final checkSave;
  bool check;
  CustomCheckBox({Key? key, required this.checkSave, required this.check})
      : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.Blue;
    }
    return AppColors.Grey;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: widget.check,
          onChanged: (bool? value) {
            setState(() {
              widget.check = value!;
              widget.checkSave(widget.check);
              AppPreferences.prefs.remove('save');
              AppPreferences.prefs.setBool('save', widget.check);
            });
          },
        ),
        Text(
          'Lưu thông tin',
          style: AppTextStyle.nunitoSize13.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isChecked ? AppColors.Blue : AppColors.Grey,
          ),
        )
      ],
    );
  }
}

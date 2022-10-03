import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final value;
  final groupValue;

  final String? title;
  final ValueChanged onChanged;

  const CustomButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: _customRadioButton,
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Material(
      elevation: isSelected ? 0 : 3,
      shadowColor: isSelected ? null : AppColors.Blue,
      child: SizedBox(
        width: 156,
        height: 54,
        child: Container(
          child: Center(
            child: Text(
              title!,
              style: AppTextStyle.nunitoSize13.copyWith(
                color: isSelected ? AppColors.White : AppColors.Blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.Blue : AppColors.White,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

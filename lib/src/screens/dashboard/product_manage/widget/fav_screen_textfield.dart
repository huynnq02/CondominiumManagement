import 'package:flutter/material.dart';

import '../../../../../utils/app_constant/app_colors.dart';
import '../../../../../utils/app_constant/app_text_style.dart';

class FAVScreenTextField extends StatefulWidget {
  final valueSearch;
  FAVScreenTextField({Key? key, required this.valueSearch}) : super(key: key);

  @override
  State<FAVScreenTextField> createState() => _FAVScreenTextFieldState();
}

class _FAVScreenTextFieldState extends State<FAVScreenTextField> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        widget.valueSearch(value);
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.MidGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.MidGrey,
            width: 1,
          ),
        ),
        hintText: 'Tên sản phẩm',
        hintStyle: AppTextStyle.nunitoSize13.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.MidGrey,
        ),
      ),
    );
  }
}

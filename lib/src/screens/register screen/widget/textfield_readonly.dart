import 'package:flutter/material.dart';

import '../../../../utils/app_constant/app_colors.dart';

class TextfieldReadonly extends StatefulWidget {
  String value;
  TextfieldReadonly({Key? key, required this.value}) : super(key: key);

  @override
  State<TextfieldReadonly> createState() => _TextfieldReadonlyState();
}

class _TextfieldReadonlyState extends State<TextfieldReadonly> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.text = widget.value;
    return TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.LightGrey,
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
        ));
  }
}

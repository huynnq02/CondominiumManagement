import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class FeedbackInput extends StatelessWidget {
  FeedbackInput(
      {Key? key,
      required this.height,
      required this.width,
      required this.hintText,
      required this.maxLength,
      required this.controller,
      required this.isError})
      : super(key: key);
  TextEditingController controller;
  String hintText;
  int maxLength;
  bool? isError;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: isError == true ? AppColors.Red : const Color(0xFFD9D9D9),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TextField(
            textAlign: TextAlign.justify,
            maxLength: maxLength,
            maxLines: 3,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(0),
              hintText: hintText,
              hintStyle: AppTextStyle.lato.copyWith(
                fontSize: 18,
                color: AppColors.Black.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class RowDetail extends StatelessWidget {
  final String title, data;
  const RowDetail({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.lato.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          data,
          style: AppTextStyle.lato.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

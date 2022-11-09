import 'package:flutter/material.dart';

import 'package:untitled/utils/app_constant/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.24),
            offset: Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Text(
        text,
        style: AppTextStyle.lexendExa.copyWith(fontSize: 14),
      ),
    );
  }
}

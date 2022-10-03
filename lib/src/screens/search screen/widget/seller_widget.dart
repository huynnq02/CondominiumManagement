// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class SellerWidget extends StatelessWidget {
  const SellerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Nơi bán:',
          style: AppTextStyle.nunitoBoldSize14,
        ),
        SizedBox(
          width: 10,
        ),
        ClipRRect(
          child: Image.asset('assets/tgdd.png'),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ],
    );
  }
}

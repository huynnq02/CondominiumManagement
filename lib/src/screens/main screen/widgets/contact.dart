import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Liên hệ',
          style: AppTextStyle.nunitoSize13.copyWith(
              color: AppColors.LightBlue,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Image.asset('assets/Logo_GSOFT.png'),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/facebook.svg',
            ),
            const SizedBox(
              width: 17,
            ),
            SvgPicture.asset(
              'assets/youtube.svg',
            ),
            const SizedBox(
              width: 17,
            ),
            SvgPicture.asset(
              'assets/linkedin.svg',
            ),
            const SizedBox(
              width: 17,
            ),
            SvgPicture.asset(
              'assets/twitter.svg',
            ),
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class NoteColumnChart extends StatelessWidget {
  const NoteColumnChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              height: 15,
              width: 15,
              color: AppColors.Green,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Bình luận tích cực',
              style: AppTextStyle.nunitoSize13.copyWith(fontSize: 10),
            )
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        Row(
          children: [
            Container(
              height: 15,
              width: 15,
              color: AppColors.Red,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Bình luận tiêu cực',
              style: AppTextStyle.nunitoSize13.copyWith(fontSize: 10),
            )
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        Row(
          children: [
            Container(
              height: 15,
              width: 15,
              color: AppColors.LightBlue,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Bình luận khác',
              style: AppTextStyle.nunitoSize13.copyWith(fontSize: 10),
            )
          ],
        )
      ],
    );
  }
}

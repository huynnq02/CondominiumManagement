import 'package:flutter/material.dart';
import 'package:untitled/src/screens/dashboard/widget/ratingbar_dashboard.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';

class OtherComments extends StatefulWidget {
  double neutral;
  OtherComments({Key? key, required this.neutral}) : super(key: key);

  @override
  State<OtherComments> createState() => _OtherCommentsState();
}

class _OtherCommentsState extends State<OtherComments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: AppColors.LightBlue, width: 0.5)),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bình luận khác',
            style: AppTextStyle.nunitoBoldSize14
                .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text('${widget.neutral}%',
              style: AppTextStyle.nunitoBoldSize14
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 15)),
          RatingBarDashboard(
            rate: widget.neutral / 10,
            colors: AppColors.Blue,
          ),
        ],
      ),
    );
  }
}

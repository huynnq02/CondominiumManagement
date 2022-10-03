import 'package:flutter/material.dart';
import 'package:untitled/src/screens/dashboard/widget/ratingbar_dashboard.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';

class NagativeComments extends StatefulWidget {
  double nagative;
  NagativeComments({Key? key, required this.nagative}) : super(key: key);

  @override
  State<NagativeComments> createState() => _NagativeCommentsState();
}

class _NagativeCommentsState extends State<NagativeComments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      height: 90,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: AppColors.LightBlue, width: 0.5)),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bình luận tiêu cực',
            style: AppTextStyle.nunitoBoldSize14
                .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text('${widget.nagative}%',
              style: AppTextStyle.nunitoBoldSize14
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 15)),
          RatingBarDashboard(
            rate: widget.nagative / 10,
            colors: AppColors.Red,
          ),
        ],
      ),
    );
  }
}

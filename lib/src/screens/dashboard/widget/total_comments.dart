import 'package:flutter/material.dart';
import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';

class TotalComments extends StatefulWidget {
  double total;
  TotalComments({Key? key, required this.total}) : super(key: key);

  @override
  State<TotalComments> createState() => _TotalCommentsState();
}

class _TotalCommentsState extends State<TotalComments> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Điểm trung bình',
            style: AppTextStyle.nunitoBoldSize14
                .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Text(widget.total.toStringAsFixed(2),
              style: AppTextStyle.nunitoBoldSize14
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 22))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/widget/custom_image.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../models/phone.dart';
import '../../../providers/compare_provider.dart';
import '../../search screen/widget/csi_detail.dart';

class ItemGridViewCompare extends StatefulWidget {
  Phone phone;
  ItemGridViewCompare({Key? key, required this.phone}) : super(key: key);

  @override
  State<ItemGridViewCompare> createState() => _ItemGridViewCompareState();
}

class _ItemGridViewCompareState extends State<ItemGridViewCompare> {
  @override
  Widget build(BuildContext context) {
    CompareProvider compareProvider;
    compareProvider = Provider.of<CompareProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(imageUrl: widget.phone.linkImage!, size: esize.medium),
          const SizedBox(
            height: 10,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(
              widget.phone.name.toString(),
              textAlign: TextAlign.center,
              style: AppTextStyle.nunitoSize13
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.phone.statistical!.overallScore.toString(),
                style: AppTextStyle.nunitoBoldSize14.copyWith(
                  color: AppColors.Blue,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '•',
                style: AppTextStyle.nunitoBoldSize14.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.phone.statistical!.labelScore.toString(),
                style: AppTextStyle.nunitoBoldSize14.copyWith(
                  fontSize: 16,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 13,
          ),
          SizedBox(
            child: CSIDetail(
              statistical: widget.phone.statistical,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 160,
            height: 42,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.Blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                compareProvider.phone1 == null
                    ? compareProvider.setPhone1(widget.phone)
                    : compareProvider.setPhone2(widget.phone);
                Navigator.pop(context, true);
              },
              child: Text(
                'So sánh',
                style: AppTextStyle.nunitoSize13.copyWith(
                    color: AppColors.White,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

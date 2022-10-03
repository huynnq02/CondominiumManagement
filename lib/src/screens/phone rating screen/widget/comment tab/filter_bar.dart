import 'package:flutter/material.dart';
import 'package:untitled/src/models/review.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/custom_drop_down_button.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'filter_overlay_comment.dart';

class FilterBar extends StatelessWidget {
  String idProduct;
  List<Review> listReview;
  FilterBar({Key? key, required this.listReview, required this.idProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Text(
          //     'Sắp xếp',
          //     style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 17),
          //   ),
          // ),
          // const SizedBox(
          //   height: 7,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FilterOverlayComment(
                idProduct: idProduct,
                list: listReview,
              ),
              // const CustomDropDownButton(),
            ],
          )
        ],
      ),
    );
  }
}

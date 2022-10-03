// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/review.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/filter_radio_button_comment.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import '../../../../providers/filter_comment_provider.dart';
class FilterComment extends StatefulWidget {
  List<Review> lisReview;
  String idProduct;
  FilterComment({
    required this.lisReview,
    required this.idProduct,
    Key? key,
  }) : super(key: key);

  @override
  State<FilterComment> createState() => _FilterCommentState();
}

class _FilterCommentState extends State<FilterComment> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterCommentProvider>(context, listen: false);
    final component = <String>[
      'Màn hình',
      'Camera',
      'Nét đặc trưng',
      'Pin',
      'Thiết kế',
      'Dung lượng lưu trữ',
      'Giá cả',
      'Hiệu suất sử dụng'
    ];
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/filter.svg'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Lọc theo tính năng',
                    style: AppTextStyle.nunitoBoldSize14.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (provider.overlayEntry != null) {
                              provider.overlayEntry!.remove();
                              provider.turnOff();
                            }
                          });
                        },
                        child: SvgPicture.asset('assets/cancel.svg'),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: component.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 6,
                mainAxisSpacing: 5,
                crossAxisSpacing: 0,
              ),
              itemBuilder: (context, index) {
                return FilterRadioButtonComment(
                  filter: component[index],
                  index: index,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 160,
              height: 42,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppColors.Orange),
                onPressed: () {
                  setState(() {
                    if (provider.overlayEntry != null) {
                     
                      provider.applyFilter(widget.idProduct);
                      provider.overlayEntry!.remove();
                      provider.turnOff();
                    }
                  });
                },
                child: Text(
                  'Hoàn tất',
                  style: AppTextStyle.nunitoSize13.copyWith(
                      color: AppColors.White,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

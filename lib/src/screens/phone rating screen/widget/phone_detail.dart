// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/screens/compare%20screen/compare_screen.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/custom_picture_button.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/price.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/rating_widget.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../../utils/app_constant/app_text_style.dart';
import '../../../models/phone.dart';
import '../../../providers/compare_provider.dart';
import '../../../widget/custom_image.dart';
import '../../search screen/widget/csi_detail.dart';
import '../../search screen/widget/seller_widget.dart';
import 'comment tab/pagecounter.dart';

class PhoneDetail extends StatelessWidget {
  Phone phone;

  PhoneDetail({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CompareProvider compareProvider;
    compareProvider = Provider.of<CompareProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.LightBlue1,
            spreadRadius: -5,
            blurRadius: 4,
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 26.0,
            left: 8,
            right: 8,
            bottom: 17,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomPictureButton(isLeft: true),
                  CustomImage(
                    imageUrl: phone.linkImage.toString(),
                    size: esize.big,
                  ),
                  CustomPictureButton(isLeft: false),
                ],
              ),
              PageCounter(),
              Text(
                phone.name.toString(),
                style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.Green,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        child: Text(
                          '${phone.statistical!.overallScore.toString()}',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.nunitoBoldSize14
                              .copyWith(fontSize: 16, color: AppColors.White),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: CSIDetail(
                        statistical: phone.statistical,
                      ),
                    ),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Price(phone: phone),
                    VerticalDivider(
                      color: AppColors.Grey,
                      thickness: 0.5,
                    ),
                    SellerWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Mức độ hài lòng',
                style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              RatingWidget(
                aspectsScore: phone.statistical!.aspectsScore!,
              ),
              SizedBox(
                height: 26,
              ),
              InkWell(
                  onTap: () {
                    compareProvider.setPhone1(phone);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CompareScreen(phone: compareProvider.phone1!)));
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/compare.svg',
                          width: 37,
                          height: 37,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'So sánh',
                          style: AppTextStyle.nunitoBoldSize14
                              .copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

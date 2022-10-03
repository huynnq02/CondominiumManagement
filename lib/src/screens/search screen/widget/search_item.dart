// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/compare_provider.dart';
import 'package:untitled/src/screens/search%20screen/widget/csi_detail.dart';
import 'package:untitled/src/screens/search%20screen/widget/custom_progess_bar.dart';
import 'package:untitled/src/screens/search%20screen/widget/seller_widget.dart';
import 'package:untitled/src/widget/custom_image.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../models/phone.dart';
import '../../compare screen/compare_screen.dart';
import '../../phone rating screen/phone_rating_screen.dart';

class SearchedItem extends StatelessWidget {
  List<Phone> phone;
  SearchedItem({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CompareProvider compareProvider;
    compareProvider = Provider.of<CompareProvider>(context, listen: true);
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: phone.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PhoneRatingScreen(phone: phone[index])),
                );
              },
              child: Container(
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CustomImage(
                              imageUrl: phone[index].linkImage.toString(),
                              size: esize.medium,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: () {
                                compareProvider.setPhone1(phone[index]);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CompareScreen(
                                            phone: compareProvider.phone1!)));
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/compare.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('So sánh',
                                      style: AppTextStyle.nunitoBoldSize14)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                phone[index].name.toString(),
                                style: AppTextStyle.nunitoBoldSize14,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Chỉ số cảm xúc (CSI)',
                                style: AppTextStyle.nunitoSize13.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              CSIDetail(
                                statistical: phone[index].statistical,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Điểm:',
                                    style: AppTextStyle.nunitoBoldSize14,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomProgressBar(
                                    phone: phone[index],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    phone[index].statistical!.overallScore !=
                                            null
                                        ? phone[index]
                                            .statistical!
                                            .overallScore
                                            .toString()
                                        : '0',
                                    style: AppTextStyle.nunitoBoldSize14,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SellerWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}

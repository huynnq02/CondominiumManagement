import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/compare_provider.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';
import '../../../models/phone.dart';
import '../../../widget/custom_image.dart';
import '../../phone rating screen/widget/price.dart';
import 'compare_csi_detail.dart';
import 'compare_rating_widget.dart';

class PhoneDetail extends StatefulWidget {
  Phone phone;
  int number;
  PhoneDetail({Key? key, required this.phone, required this.number})
      : super(key: key);

  @override
  State<PhoneDetail> createState() => _PhoneDetailState();
}

class _PhoneDetailState extends State<PhoneDetail> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompareProvider>(context, listen: false);
    return Container(
        color: AppColors.White,
        child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 8,
              right: 8,
              bottom: 17,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                        ),
                        onPressed: () {
                          widget.number == 1
                              ? provider.removePhone1()
                              : provider.removePhone2();
                        },
                      )),
                  CustomImage(
                    imageUrl: widget.phone.linkImage.toString(),
                    size: esize.medium,
                  ),
                  Text(
                    widget.phone.name.toString(),
                    style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.Green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 7,
                    ),
                    child: Text(
                      '${widget.phone.statistical!.overallScore} - ${widget.phone.statistical!.labelScore}',
                      style: AppTextStyle.nunitoBoldSize14
                          .copyWith(fontSize: 14, color: AppColors.White),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CompareCSIDetail(),
                  const SizedBox(
                    height: 8,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Price(
                          phone: widget.phone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Mức độ hài lòng',
                    style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CompareRatingWidget(
                      rate: double.parse(widget
                          .phone.statistical!.aspectsScore!.sCREEN
                          .toString()),
                      typeOfRate: 'Màn hình'),
                  CompareRatingWidget(
                      rate: double.parse(widget
                          .phone.statistical!.aspectsScore!.gENERAL
                          .toString()),
                      typeOfRate: 'Nét đặc trưng '),
                  CompareRatingWidget(
                      rate: double.parse(widget
                          .phone.statistical!.aspectsScore!.cAMERA
                          .toString()),
                      typeOfRate: 'Camera'),
                  CompareRatingWidget(
                      rate: double.parse(widget
                          .phone.statistical!.aspectsScore!.bATTERY
                          .toString()),
                      typeOfRate: 'Pin'),
                  CompareRatingWidget(
                      rate: double.parse(widget
                          .phone.statistical!.aspectsScore!.dESIGN
                          .toString()),
                      typeOfRate: 'Thiết kế'),
                  CompareRatingWidget(
                      rate: double.parse(widget
                          .phone.statistical!.aspectsScore!.pRICE
                          .toString()),
                      typeOfRate: 'Giá cả'),
                  CompareRatingWidget(
                      rate: double.parse(widget
                          .phone.statistical!.aspectsScore!.sTORAGE
                          .toString()),
                      typeOfRate: 'Dung lượng lưu trữ'),
                  CompareRatingWidget(
                      rate: double.parse(widget
                          .phone.statistical!.aspectsScore!.pERFORMANCE
                          .toString()),
                      typeOfRate: 'Hiệu suất sử dụng'),
                ])));
  }
}

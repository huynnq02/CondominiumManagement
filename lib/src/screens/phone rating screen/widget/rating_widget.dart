// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/src/models/aspects_score.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/rating_bar.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class RatingWidget extends StatelessWidget {
  AspectsScore aspectsScore;

  RatingWidget({Key? key, required this.aspectsScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List listRate = [
      aspectsScore.sCREEN,
      aspectsScore.gENERAL,
      aspectsScore.bATTERY,
      aspectsScore.cAMERA,
      aspectsScore.dESIGN,
      aspectsScore.pERFORMANCE,
      aspectsScore.pRICE,
      aspectsScore.sTORAGE
    ];
    List typeOfRate = [
      'Màn hình',
      'Nét đặt trưng',
      'Pin',
      'Camera',
      'Thiết kế',
      'Hiệu suất',
      'Giá',
      'Dung lượng'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: ((context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar(rate: listRate[index]),
                  Text(
                    typeOfRate[index],
                    style: AppTextStyle.nunitoSize13.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              );
            }))
      ],
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/src/models/review.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class Comment extends StatelessWidget {
  List<Review> review;
  int length;
  String date;
  Comment(
      {Key? key,
      required this.review,
      required this.length,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${length} bình luận ',
                style: AppTextStyle.nunitoBoldSize14,
              ),
              Text(
                'Cập nhật ngày : ${date}',
                style: AppTextStyle.nunitoBoldSize14,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: review.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            review[index].comment.toString(),
                            style: AppTextStyle.robotoSize14,
                          ),
                          SizedBox(
                            height: 17,
                          ),
                        ],
                      ),
                    )
                  ]);
            },
          ),
        ]));
  }
}

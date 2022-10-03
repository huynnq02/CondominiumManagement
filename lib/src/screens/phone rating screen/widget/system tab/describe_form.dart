// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class DescribeForm extends StatefulWidget {
  String content;
  DescribeForm({Key? key, required this.content}) : super(key: key);

  @override
  State<DescribeForm> createState() => _DescribeFormState();
}

class _DescribeFormState extends State<DescribeForm> {
  bool isReadmore = false;

  Widget buildText(String text) {
    // if read more is false then show only 3 lines from text
    // else show full text
    final lines = isReadmore ? null : 10;
    return Text(
      text,
      style: AppTextStyle.robotoSize14.copyWith(
        wordSpacing: 3.5,
        fontSize: 15,
      ),
      maxLines: lines,
      // overflow properties is used to show 3 dot in text widget
      // so that user can understand there are few more line to read.
      overflow: isReadmore ? TextOverflow.visible : TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    final document = parse(widget.content);
    final finalString = document.documentElement?.text;

    return finalString != null
        ? Stack(
            children: [
              Padding(
                padding: isReadmore
                    ? EdgeInsets.only(
                        bottom: 100,
                      )
                    : EdgeInsets.only(
                        bottom: 20,
                      ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    buildText(
                      finalString,
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      // Box decoration takes a gradient
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.1, 0.7],
                        colors: [
                          // Colors are easy thanks to Flutter's Colors class.
                          Colors.white.withOpacity(0.6),
                          Colors.white
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 169,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.White,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                              side: BorderSide(
                                  width: 0.5, color: AppColors.Black),
                            ),
                            onPressed: () {
                              setState(() {
                                // toggle the bool variable true or false
                                isReadmore = !isReadmore;
                              });
                            },
                            child: Text(
                              (isReadmore ? 'Thu nhỏ' : 'Xem thêm'),
                              style: AppTextStyle.nunitoBoldSize14.copyWith(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        : Text(
            'Chưa có mô tả',
          );
  }
}

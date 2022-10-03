import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/manage_paginator_provider.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'dart:math' as math;

import '../../../../../utils/app_constant/app_colors.dart';

class PaginatorManage extends StatefulWidget {
  int state;
  int length;
  PaginatorManage({Key? key, required this.length, required this.state})
      : super(key: key);

  @override
  State<PaginatorManage> createState() => _PaginatorManageState();
}

class _PaginatorManageState extends State<PaginatorManage> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ManagePaginatorProvider>(context, listen: true);
    Widget reveseAssetButton(String assetImage, int state) {
      return Expanded(
        child: SizedBox(
          width: 50,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                provider.onchange(state);
              });
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: SvgPicture.asset(assetImage),
            ),
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: AppColors.Grey, width: 1),
              shape: const CircleBorder(),
            ),
          ),
        ),
      );
    }

    Widget normalAssetButton(String assetImage, int state) {
      return Expanded(
        child: SizedBox(
          width: 50,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                provider.onchange(state);
              });
            },
            child: Center(child: SvgPicture.asset(assetImage)),
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: AppColors.Grey, width: 1),
              shape: const CircleBorder(),
            ),
          ),
        ),
      );
    }

    Widget normalButton(String buttonText, int state) {
      return Expanded(
        child: SizedBox(
            width: 55,
            height: 55,
            child: GestureDetector(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    provider.onchange(state);
                  });
                },
                child: Text(buttonText,
                    style: AppTextStyle.robotoSize14.copyWith(fontSize: 11)),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: AppColors.Grey, width: 1),
                  shape: const CircleBorder(),
                ),
              ),
            )),
      );
    }

    Widget selectedButton(String inputText) {
      return Expanded(
        child: SizedBox(
          width: 55,
          height: 55,
          child: OutlinedButton(
            onPressed: () {
              setState(() {});
            },
            child: Text(
              inputText,
              style: AppTextStyle.robotoSize14
                  .copyWith(fontSize: 11, color: AppColors.White),
            ),
            style: ElevatedButton.styleFrom(
              primary: AppColors.Blue,
              side: const BorderSide(color: AppColors.Blue, width: 1),
              shape: const CircleBorder(),
            ),
          ),
        ),
      );
    }

    Widget nullButton() {
      return Expanded(
        child: SizedBox(
          width: 55,
          height: 55,
          child: OutlinedButton(
            onPressed: () {
              setState(() {});
            },
            child: Text(
              '',
              style: AppTextStyle.robotoSize14
                  .copyWith(fontSize: 11, color: AppColors.White),
            ),
            style: ElevatedButton.styleFrom(
              // primary: AppColors.White,
              side: const BorderSide(style: BorderStyle.none),
              shape: const CircleBorder(),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 8,
          right: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            normalAssetButton('assets/first.svg', 1),
            const SizedBox(
              width: 6,
            ),
            normalAssetButton('assets/previous.svg',
                widget.state == 1 ? widget.state : widget.state - 1),
            const SizedBox(
              width: 6,
            ),
            provider.state == 1
                ? selectedButton(
                    '1',
                  )
                : provider.state == widget.length
                    ? normalButton(
                        (widget.state - 1).toString(), (widget.state - 1))
                    : normalButton(
                        (widget.state - 1).toString(), (widget.state - 1)),
            const SizedBox(
              width: 6,
            ),
            widget.length < 2
                ? nullButton()
                : provider.state == 1
                    ? normalButton('2', widget.state + 1)
                    : widget.length == 2 && provider.state == 2
                        ? selectedButton('2')
                        : provider.state == widget.length
                            ? selectedButton((widget.state).toString())
                            : selectedButton((widget.state).toString()),
            const SizedBox(
              width: 6,
            ),
            widget.length < 3
                ? nullButton()
                : widget.state == 1
                    ? normalButton('3', widget.state + 2)
                    : provider.state == widget.length
                        ? nullButton()
                        : normalButton(
                            (widget.state + 1).toString(), (widget.state + 1)),
            const SizedBox(
              width: 6,
            ),
            reveseAssetButton(
                'assets/previous.svg',
                widget.state == widget.length
                    ? widget.state
                    : widget.state + 1),
            const SizedBox(
              width: 6,
            ),
            reveseAssetButton('assets/first.svg', widget.length)
          ],
        ),
      ),
    );
  }
}

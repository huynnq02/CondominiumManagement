import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:untitled/utils/app_constant/app_colors.dart';

class CustomPictureButton extends StatelessWidget {
  final bool isLeft;
  const CustomPictureButton({
    Key? key,
    required this.isLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        shape: const CircleBorder(),
        elevation: 3,
        shadowColor: AppColors.Blue,
        child: SizedBox(
          width: 35,
          height: 35,
          child: OutlinedButton(
            onPressed: () {},
            child: isLeft
                ? Center(child: SvgPicture.asset('assets/blue-previous.svg'))
                : Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: SvgPicture.asset('assets/blue-previous.svg'),
                    ),
                  ),
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: AppColors.Blue, width: 0.1),
              shape: const CircleBorder(),
            ),
          ),
        ),
      ),
    );
  }
}

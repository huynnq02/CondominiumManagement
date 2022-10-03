import 'package:flutter/material.dart';

import '../../../../../utils/app_constant/app_colors.dart';

class FavCustomRatingBar extends StatefulWidget {
  final rate;
  const FavCustomRatingBar({Key? key, required this.rate}) : super(key: key);

  @override
  State<FavCustomRatingBar> createState() => _FavCustomRatingBarState();
}

class _FavCustomRatingBarState extends State<FavCustomRatingBar> {
  @override
  Widget build(BuildContext context) {
    var width = 70.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 12,
          width: width,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.LightGrey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              Container(
                width: width * (widget.rate * 10) / 100,
                decoration: const BoxDecoration(
                  color: AppColors.Green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

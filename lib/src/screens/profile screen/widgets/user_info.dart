import 'package:flutter/material.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';

class UserInfo extends StatelessWidget {
  final String info;
  final String value;
  final String icon;
  final double? topRadius, bottomRadius;
  final bool? shadow;
  const UserInfo({
    Key? key,
    required this.info,
    required this.value,
    required this.icon,
    this.topRadius,
    this.bottomRadius,
    this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius ?? 0),
          topRight: Radius.circular(topRadius ?? 0),
          bottomLeft: Radius.circular(bottomRadius ?? 0),
          bottomRight: Radius.circular(bottomRadius ?? 0),
        ),
        border: Border.all(
            color: const Color(0x00000033).withOpacity(0.20), width: 1),
        color: AppColors.White,
        boxShadow: shadow != null
            ? const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 3,
                  offset: Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 13,
          bottom: 13,
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage('assets/$icon.png'),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              info,
              style: AppTextStyle.lato.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: AppTextStyle.lato.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

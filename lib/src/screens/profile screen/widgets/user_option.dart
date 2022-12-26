import 'package:flutter/material.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';

class UserOption extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final String icon;
  final double? topRadius, bottomRadius;
  final bool? shadow;
  final Color? backgroundColor, textColor, borderColor;

  const UserOption({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.icon,
    this.topRadius,
    this.bottomRadius,
    this.shadow,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        color: backgroundColor ?? AppColors.White,
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
              image: AssetImage('assets/$leadingIcon.png'),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              title,
              style: AppTextStyle.lato.copyWith(
                fontSize: 16,
                color: textColor ?? AppColors.Black,
              ),
            ),
            const Spacer(),
            Image(
              image: AssetImage('assets/$icon.png'),
            ),
          ],
        ),
      ),
    );
  }
}

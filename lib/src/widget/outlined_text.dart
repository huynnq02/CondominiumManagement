import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_shadows.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final Color? strokeColor;
  final TextAlign? textAlign;
  TextStyle? style;
  final bool isShadowed;
  OutlinedText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.color,
      this.strokeColor,
      this.textAlign,
      this.style = const TextStyle(),
      this.isShadowed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(text,
            textAlign: textAlign,
            style: style!.copyWith(
                fontSize: fontSize,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = strokeColor ?? Colors.black.withOpacity(0.2),
                shadows: isShadowed
                    ? AppShadows.defaultShadows
                    : null)),
        Text(text,
            textAlign: textAlign,
            style: style!.copyWith(
              fontSize: fontSize,
              color: color ?? Colors.white,
            )),
      ],
    );
  }
}

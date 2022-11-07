import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final Color? strokeColor;
  final TextAlign? textAlign;
  const OutlinedText({
    Key? key,
    required this.text,
    this.fontSize,
    this.color,
    this.strokeColor,
    this.textAlign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = strokeColor ?? Colors.black.withOpacity(0.2),
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}

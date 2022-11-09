import 'package:flutter/material.dart';


class BoxMessage extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;

  const BoxMessage({
    Key? key,
    required this.child,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF000000).withOpacity(0.2),
        ),
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}

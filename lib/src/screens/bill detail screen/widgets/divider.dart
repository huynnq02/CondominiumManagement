import 'package:flutter/material.dart';

class divider extends StatelessWidget {
  const divider({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02, bottom: height * 0.02),
      child: const Divider(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        thickness: 1,
      ),
    );
  }
}

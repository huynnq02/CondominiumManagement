import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeItem extends StatelessWidget {
  final String title;
  final String iconPath;
  const HomeItem({Key? key, required this.title, required this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  shadowColor: Colors.transparent),
              onPressed: () {},
              child: SvgPicture.asset(iconPath, width: 35, height: 35)),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 80,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

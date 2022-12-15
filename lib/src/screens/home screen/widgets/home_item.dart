import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final String title;
  final String iconPath;
  const HomeItem({
    Key? key,
    required this.title,
    required this.iconPath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
              onPressed: () {},
              child: Image.asset(
                  iconPath,
                  width: 32,
                  height: 32)),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
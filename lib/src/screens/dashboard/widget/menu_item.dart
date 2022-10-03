import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  String title;
  IconData icon;
  MenuItem({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      child: GestureDetector(
        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.black,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              title,
              style: const TextStyle(fontSize: 23, color: Colors.black),
            ))
          ],
        ),
      ),
    );
  }
}

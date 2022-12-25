import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  final String title;
  final String value;
  const InfoField({
    Key? key,
    required this.title,
    required this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24,top: 13, bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFFDB2F68)
          ),),
          const SizedBox(height: 8,),
          Text(value, style: const TextStyle(fontSize: 18),)
        ],
      ),
    );
  }
}
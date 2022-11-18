import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class FeedBackType extends StatelessWidget {
  final int selectedIndex, index;
  final Color colorOntap;
  final String title;

  const FeedBackType(
      {Key? key,
      required this.selectedIndex,
      required this.colorOntap,
      required this.index,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.05,
      width: width * 0.25,
      decoration: BoxDecoration(
        color: selectedIndex == index ? colorOntap : const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20),
        // set border for container
        border: Border.all(
          color: AppColors.Black.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: AppTextStyle.lato.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: selectedIndex == index ? AppColors.White : AppColors.Black,
          ),
        ),
      ),
    );
  }
}

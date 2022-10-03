import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class WidgetLoad extends StatelessWidget {
  const WidgetLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          const CircularProgressIndicator(
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          Text('Loading...',
              style: AppTextStyle.nunitoBoldSize14.copyWith(
                color: AppColors.Grey,
              ))
        ],
      ),
    );
  }
}

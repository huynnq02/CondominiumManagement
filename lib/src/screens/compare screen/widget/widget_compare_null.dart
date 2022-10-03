import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class WidgetCompareNull extends StatelessWidget {
  const WidgetCompareNull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Text('Vui lòng chọn sản phẩm so sánh',
          style: AppTextStyle.nunitoBoldSize14, textAlign: TextAlign.center),
    );
  }
}

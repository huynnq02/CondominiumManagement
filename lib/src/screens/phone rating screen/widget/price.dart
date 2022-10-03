import 'package:flutter/material.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class Price extends StatelessWidget {
  Phone? phone;
  Price({Key? key, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: 'Giá bán: ',
            style: AppTextStyle.nunitoBoldSize14
                .copyWith(fontWeight: FontWeight.normal),
            children: <TextSpan>[
              TextSpan(
                text: phone!.price != null
                    ? '${phone!.price} đ'
                    : '${phone!.promotionprice} đ',
                style: AppTextStyle.nunitoBoldSize14
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

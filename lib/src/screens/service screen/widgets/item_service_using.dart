import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/screens/service%20screen/service_detail_cancel_screen.dart';
import 'package:untitled/src/screens/service%20screen/service_detail_screen.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ItemServiceUsing extends StatelessWidget {
  final UserService service;
  final int index;

  const ItemServiceUsing({
    Key? key,
    required this.service,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.serviceName,
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Loại dịch vụ: ',
                      style: AppTextStyle.robotoSize14,
                      children: <TextSpan>[
                        TextSpan(
                          text: service.serviceName,
                          style: AppTextStyle.lato.copyWith(
                            color: AppColors.Orange,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Chu kì: ',
                      style: AppTextStyle.robotoSize14,
                      children: <TextSpan>[
                        TextSpan(
                          text: service.cycle + ' ngày',
                          style: AppTextStyle.lato.copyWith(
                            color: AppColors.Orange,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Expanded(
                child: Image.asset(
                  'assets/service.png',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Phí: ',
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: service.price.round().toVND(),
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          ServiceDetailCancelScreen(
                        service: service,
                        index: index,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8A00),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Xem thêm',
                    style: AppTextStyle.lato.copyWith(
                      color: AppColors.White,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

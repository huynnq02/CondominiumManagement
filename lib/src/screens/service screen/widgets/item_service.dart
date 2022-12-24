import 'package:flutter/material.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class ItemService extends StatelessWidget {
  final ApartmentService service;

  const ItemService({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFFFFFDFD),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/service.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                service.serviceName,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.lato.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Chi phí:    ',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    service.serviceCharge.toVND(),
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFDB2F68),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

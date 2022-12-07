import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:untitled/repository/service/serviceAPI_provider.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/screens/service%20screen/widgets/register_dialog.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ApartmentService service;

  const ServiceDetailScreen({
    Key? key,
    required this.service,
  }) : super(key: key);

  // void registerService(BuildContext context) async {
  //   final ServicePro servicePro = ServicePro();
  //   Service service =
  //   String status = await servicePro.registerService();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D6D54),
        elevation: 0,
        title: Text(
          'Chi tiết dịch vụ',
          style: AppTextStyle.lato.copyWith(
            color: AppColors.White,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.2,
          ),
          child: ListView(
            children: [
              //const Spacer(),
              Image.asset(
                'assets/service.png',
                width: size.width * .6,
                height: size.height * .25,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Tên dịch vụ: ',
                      style: AppTextStyle.robotoSize14.copyWith(fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: service.serviceName,
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Phí: ',
                      style: AppTextStyle.robotoSize14.copyWith(fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: service.serviceCharge.round().toVND(),
                          style: AppTextStyle.lato.copyWith(
                            color: AppColors.Orange,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Chu kì: ',
                      style: AppTextStyle.robotoSize14.copyWith(fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: service.cycle,
                          style: AppTextStyle.lato.copyWith(
                            color: AppColors.Orange,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Đơn vị chịu trách nhiệm: ',
                      style: AppTextStyle.robotoSize14.copyWith(fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: service.responsibleUnit,
                          style: AppTextStyle.lato.copyWith(
                            color: AppColors.Orange,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Mô tả: ',
                    style: AppTextStyle.robotoSize14.copyWith(fontSize: 16),
                  ),
                  Text(
                    service.describe ?? '',
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return RegisterDialog(
                        apartmentService: service,
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF1D6D54),
                  ),
                  child: Center(
                    child: Text(
                      'Đăng kí',
                      style: AppTextStyle.lato.copyWith(
                        color: AppColors.White,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

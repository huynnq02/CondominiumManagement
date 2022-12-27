import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:untitled/repository/service/serviceAPI_provider.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/screens/service%20screen/confirm_register_service_screen.dart';
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
        backgroundColor: const Color(0xFFDB2F68),
        elevation: 0,
        title: Text(
          'Chi tiết dịch vụ',
          style: AppTextStyle.lato.copyWith(
            color: AppColors.White,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFCF6F6),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
          ),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/service.png',
                      height: size.height * .25,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Tên dịch vụ',
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      service.serviceName,
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Đơn vị chịu trách nhiệm',
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      service.responsibleUnit!,
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Mô tả',
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      service.describe!,
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Phí',
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      service.serviceCharge.toVND() +
                          '/' +
                          service.cycle +
                          ' ngày',
                      style: AppTextStyle.lato.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFDB2F68)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfirmRegisterServiceScreen(
                        service: service,
                      ),
                    ),
                  );
                  // final bool? result = await showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return RegisterDialog(
                  //       apartmentService: service,
                  //     );
                  //   },
                  // );
                  // if (result == true) {
                  //   Navigator.pop(context, true);
                  // }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFDB2F68),
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

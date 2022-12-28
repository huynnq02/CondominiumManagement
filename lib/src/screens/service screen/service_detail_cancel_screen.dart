import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/repository/service/serviceAPI_provider.dart';

import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/providers/user_service_provider.dart';
import 'package:untitled/src/screens/service%20screen/widgets/delete_service_dialog.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class ServiceDetailCancelScreen extends StatelessWidget {
  final UserService service;
  final int index;

  const ServiceDetailCancelScreen({
    Key? key,
    required this.service,
    required this.index,
  }) : super(key: key);

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
                    Align(
                      alignment: Alignment.center,
                      child: Image.network(
                        service.urlPicture!,
                        height: size.height * .25,
                        fit: BoxFit.cover,
                      ),
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
                    // Text(
                    //   'Đơn vị chịu trách nhiệm',
                    //   style: AppTextStyle.lato.copyWith(
                    //     fontSize: 15,
                    //     color: Colors.black54,
                    //   ),
                    // ),
                    // const SizedBox(height: 5),
                    // Text(
                    //   service.!,
                    //   style: AppTextStyle.lato.copyWith(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    Text(
                      'Chu kì',
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      service.cycle + " ngày",
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
                      service.price.toVND() + '/' + service.cycle + ' ngày',
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFDB2F68),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final bool? result = await showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteServiceDialog(
                        userService: service,
                        index: index,
                      );
                    },
                  );
                  if (result == true) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFDB2F68),
                  ),
                  child: Center(
                    child: Text(
                      'Huỷ đăng kí',
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/repository/service/serviceAPI_provider.dart';

import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/providers/user_service_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class ServiceDetailCancelScreen extends StatelessWidget {
  final UserService service;

  const ServiceDetailCancelScreen({
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
        backgroundColor: const Color(0xFF2A3072),
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
              SizedBox(height: size.height * 0.1),
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
                          text: service.price.round().toVND(),
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
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          color: Colors.transparent,
                          height: size.height * 0.18,
                          width: size.width * 0.8,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: Color(0xFF2A3072),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 17, left: 8, right: 8),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Bạn có chắc chắn không?",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.023,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await ServicePro()
                                                  .cancelService(service);
                                              context
                                                  .read<UserServiceProvider>()
                                                  .cancelService(service);
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              fixedSize: Size(
                                                size.width * 0.28,
                                                size.height * 0.035,
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14)),
                                              ),
                                            ),
                                            child: const Text(
                                              "Có",
                                              style: TextStyle(
                                                  color: AppColors.Black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.08,
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF2A3072),
                                              fixedSize: Size(
                                                size.width * 0.28,
                                                size.height * 0.035,
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(14),
                                                ),
                                                side: BorderSide(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              "Không",
                                              style: TextStyle(
                                                color: AppColors.White,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF2A3072),
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

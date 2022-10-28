import "package:flutter/material.dart";
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login-screen-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Text(
                          "Nhập số điện thoại mới",
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 24,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = AppColors.Black.withOpacity(0.2),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Nhập số điện thoại mới",
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 24,
                            color: AppColors.White,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    height: height * 0.095,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      color: AppColors.White.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Column(
                        children: [
                          Text(
                            "Số điện thoại",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 14,
                              color: AppColors.Black.withOpacity(0.5),
                            ),
                          ),
                          // SizedBox(
                          //   height: height * 0.0001,
                          // ),
                          Center(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Nhập số điện thoại",
                                hintStyle: AppTextStyle.lato.copyWith(
                                  fontSize: 18,
                                  color: AppColors.Black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

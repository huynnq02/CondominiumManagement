// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/src/screens/register%20screen/widget/textfield_readonly.dart';
import 'package:untitled/src/screens/register%20screen/widget/widget_button.dart';

import '../../../utils/app_constant/app_colors.dart';
import '../../../utils/app_constant/app_text_style.dart';
import '../../widget/custom_textfield.dart';

class MailCertificateScreen extends StatelessWidget {
  const MailCertificateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.White,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.grey.shade700,
                size: 35,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height - 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Cài đặt tài khoản',
                        style: AppTextStyle.nunitoSize13.copyWith(
                            color: AppColors.Blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Tên',
                            style: AppTextStyle.nunitoBoldSize14.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Text('*', style: TextStyle(color: AppColors.Red))
                        ],
                      ),
                      CustomTextField(
                        input: 'Nhập tên của bạn...',
                        type: iconType.name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Họ',
                            style: AppTextStyle.nunitoBoldSize14.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Text('*', style: TextStyle(color: AppColors.Red))
                        ],
                      ),
                      CustomTextField(
                        input: 'Nhập họ của bạn...',
                        type: iconType.name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Địa chỉ email',
                            style: AppTextStyle.nunitoBoldSize14.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      TextfieldReadonly(value: 'gmail.com'),
                      SizedBox(
                        height: 18,
                      ),
                      WidgetButton(),
                    ],
                  )),
              Image.asset('assets/slide2.png')
            ])));
  }
}

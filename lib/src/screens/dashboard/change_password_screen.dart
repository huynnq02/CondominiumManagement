// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/widget/custom_textfield.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../utils/app_constant/app_colors.dart';

class ChagePasswordScreen extends StatelessWidget {
  ChagePasswordScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? curentPassword;
  String? newPassword;
  String? newPassword1;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
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
      body: Container(
          color: AppColors.White,
          alignment: Alignment.center,
          child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 60,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Thay Đổi Mật Khẩu',
                                  style: AppTextStyle.nunitoSize13.copyWith(
                                      color: AppColors.Blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  input: 'Nhập mật khẩu cũ...',
                                  type: iconType.lock,
                                  valueString: (value) =>
                                      curentPassword = value,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  input: 'Nhập mật khẩu mới...',
                                  type: iconType.lock,
                                  valueString: (value) => newPassword = value,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  input: 'Nhập lại mật khẩu mới...',
                                  type: iconType.lock,
                                  valueString: (value) => newPassword1 = value,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 382,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColors.Blue),
                                    onPressed: () {
                                      //validate rỗng các ô nhập
                                      if (_formKey.currentState!.validate()) {
                                        provider.changePassword(
                                            context,
                                            newPassword,
                                            newPassword1,
                                            curentPassword);
                                      }
                                    },
                                    child: Text(
                                      'Đổi mật khẩu',
                                      style: AppTextStyle.nunitoSize13.copyWith(
                                          color: AppColors.White,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Image.asset('assets/slide2.png')
                      ],
                    ),
                  )))),
    );
  }
}

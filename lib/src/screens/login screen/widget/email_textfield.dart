// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class EmailTextField extends StatefulWidget {
  String valueEmail;
  bool check;
  final email;
  EmailTextField(
      {Key? key,
      required this.email,
      required this.valueEmail,
      required this.check})
      : super(key: key);

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final controller = new TextEditingController();

  String? valueEmail;
  late LoginProvider loginProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.setAccount(
        value: widget.valueEmail,
        controller: controller,
        checkBox: widget.check);
    widget.email(controller.text); //trả về nếu đã lưu thông tin
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // return TextFormField(
    //   validator: (value) {
    //     // Check if this field is empty
    //     if (value == null || value.isEmpty) {
    //       return '     Vui lòng nhập email';
    //     } else if (!value.isValidEmail()) {
    //       return '     Email không hợp lệ';
    //     }
    //   },
    //   controller: controller,
    //   onChanged: (value) {
    //     setState(() {
    //       valueEmail = value;
    //       widget.email(valueEmail);
    //     });
    //   },
    //   style: TextStyle(fontSize: 14),
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.only(top: 12, bottom: 12),
    //     label: Text(
    //       'Email',
    //       style: AppTextStyle.nunitoSize13.copyWith(
    //           fontSize: 14,
    //           fontWeight: FontWeight.normal,
    //           color: AppColors.MidGrey),
    //     ),
    //     floatingLabelBehavior: FloatingLabelBehavior.auto,
    //     focusedBorder: _buildBorder(AppColors.Blue),
    //     enabledBorder: _buildBorder(AppColors.MidGrey),
    //     focusedErrorBorder: _buildBorder(AppColors.Red),
    //     border: _buildBorder(AppColors.MidGrey),
    //     errorBorder: _buildBorder(AppColors.Red),

    //     hintText: "Điền email của bạn...",
    //     hintStyle: AppTextStyle.nunitoSize13.copyWith(
    //       fontSize: 14,
    //       fontWeight: FontWeight.normal,
    //       color: AppColors.MidGrey,
    //     ),
    //     // prefixText: "Tài khoản",
    //     prefixIcon: Padding(
    //       padding:
    //           const EdgeInsets.only(left: 17, right: 10, top: 12, bottom: 14),
    //       child: Icon(
    //         Icons.people,
    //         color: AppColors.Black,
    //         size: 22,
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      height: height * 0.084,
      width: width * 0.83,
      decoration: BoxDecoration(
        color: AppColors.White.withOpacity(0.8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 25),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  // Check if this field is empty
                  // if (value == null || value.isEmpty) {
                  //   showDialog(context: context, builder: builder)
                  // } else if (!value.isValidEmail()) {
                  //   return '     Email không hợp lệ';
                  // }
                },
                controller: controller,
                onChanged: (value) {
                  setState(() {
                    valueEmail = value;
                    widget.email(valueEmail);
                  });
                },
                maxLength: 50,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  label: Text(
                    'Email',
                    style: AppTextStyle.nunitoSize13.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppColors.Black),
                  ),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  counterText: "",
                  hintText: "Nhập email của bạn",
                  hintStyle: AppTextStyle.nunitoSize13.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColors.MidGrey,
                  ),
                  suffix: Text(
                    "@gmail.com",
                    style: AppTextStyle.nunitoSize13.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: AppColors.MidGrey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        width: 1.5,
        color: color,
      ),
    );
  }
}

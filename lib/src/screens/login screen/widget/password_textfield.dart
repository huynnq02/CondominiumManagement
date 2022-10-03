// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../../utils/app_constant/app_text_style.dart';

class PasswordTextField extends StatefulWidget {
  String valuePassword;
  final password;
  bool check;
  PasswordTextField(
      {Key? key,
      this.password,
      required this.valuePassword,
      required this.check})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  final controller = new TextEditingController();
  String? valuePassword;

  late LoginProvider loginProvider;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.setAccount(
        value: widget.valuePassword,
        controller: controller,
        checkBox: widget.check);
    widget.password(controller.text); //trả về nếu đã lưu thông tin
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: ((value) => value!.isEmpty ? 'Vui lòng nhập mật khẩu' : null),
      controller: controller,
      onChanged: (value) {
        setState(() {
          valuePassword = value;
          widget.password(valuePassword);
        });
      },
      obscureText: _obscureText,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 12, bottom: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.MidGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.MidGrey,
            width: 1,
          ),
        ),
        hintText: "Nhập mật khẩu...",
        hintStyle: AppTextStyle.nunitoSize13.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.MidGrey,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 17,
            right: 10,
          ),
          child: SvgPicture.asset(
            'assets/password.svg',
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 14, right: 17),
          child: GestureDetector(
            onTap: _toggle,
            child: SvgPicture.asset(
              'assets/eye.svg',
              width: 17,
              height: 17,
            ),
          ),
        ),
      ),
    );
  }
}

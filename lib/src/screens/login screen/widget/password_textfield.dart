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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // return TextFormField(
    //   validator: ((value) =>
    //       value!.isEmpty ? '     Vui lòng nhập mật khẩu' : null),
    //   controller: controller,
    //   onChanged: (value) {
    //     setState(() {
    //       valuePassword = value;
    //       widget.password(valuePassword);
    //     });
    //   },
    //   obscureText: _obscureText,
    //   style: TextStyle(fontSize: 14),
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.only(top: 12, bottom: 12),
    //     floatingLabelBehavior: FloatingLabelBehavior.auto,
    //     focusedBorder: _buildBorder(AppColors.Blue),
    //     enabledBorder: _buildBorder(AppColors.MidGrey),
    //     focusedErrorBorder: _buildBorder(AppColors.Red),
    //     border: _buildBorder(AppColors.MidGrey),
    //     errorBorder: _buildBorder(AppColors.Red),
    //     label: Text(
    //       'Mật khẩu',
    //       style: AppTextStyle.nunitoSize13.copyWith(
    //           fontSize: 14,
    //           fontWeight: FontWeight.normal,
    //           color: AppColors.MidGrey),
    //     ),
    //     hintText: "Nhập mật khẩu...",
    //     hintStyle: AppTextStyle.nunitoSize13.copyWith(
    //       fontSize: 14,
    //       fontWeight: FontWeight.normal,
    //       color: AppColors.MidGrey,
    //     ),
    //     prefixIcon: Padding(
    //       padding:
    //           const EdgeInsets.only(left: 17, right: 10, top: 12, bottom: 14),
    //       child: Icon(
    //         Icons.lock,
    //         color: AppColors.Black,
    //         size: 22,
    //       ),
    //     ),
    //     suffixIcon: Padding(
    //       padding: const EdgeInsets.only(top: 0, bottom: 0, right: 17),
    //       child: IconButton(
    //         icon: Icon(
    //           _obscureText ? Icons.visibility_off : Icons.visibility,
    //           size: 20,
    //           color: AppColors.Black,
    //         ),
    //         onPressed: _toggle,
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
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {},
                controller: controller,
                onChanged: (value) {
                  setState(() {
                    valuePassword = value;
                    widget.password(valuePassword);
                  });
                },
                style: TextStyle(fontSize: 14),
                obscureText: _obscureText,
                decoration: InputDecoration(
                  label: Text(
                    'Password',
                    style: AppTextStyle.nunitoSize13.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppColors.Black),
                  ),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  hintText: "Nhập mật khẩu của bạn",
                  hintStyle: AppTextStyle.nunitoSize13.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColors.MidGrey,
                  ),
                  suffixIcon: Padding(
                    padding:
                        const EdgeInsets.only(top: 0, bottom: 0, right: 17),
                    child: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                        color: AppColors.Black,
                      ),
                      onPressed: _toggle,
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

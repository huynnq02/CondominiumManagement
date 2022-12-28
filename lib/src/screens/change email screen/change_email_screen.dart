import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';
import 'package:flutter/services.dart';

class ChangeEmailScreen extends StatefulWidget {
  MDUser? mdUser;
  ChangeEmailScreen({Key? key, this.mdUser}) : super(key: key);

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  bool? _isValidOTP, _isDone, _isValidEmail, _isOldEmail;
  bool _isExpired = true;
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String? otp;
  int min = 0, sec = 60;
  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      _isExpired = false;
      if (min == 0 && sec == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            _isExpired = true;

            min = 0;
            sec = 60;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            if (min > 0 && sec == 0) {
              min--;
              sec = 60;
            }
            //_isWaiting = true;
            sec--;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileProvider>(context);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.AppBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.RedTheme,
        elevation: 0,
        title: Text(
          "Cập nhật địa chỉ email",
          style: AppTextStyle.lato.copyWith(
            fontSize: 23,
            color: AppColors.White,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.White,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            height: height,
            width: width,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Expanded(
                  child: Column(
                    children: [
                      _isDone == true
                          ? const Image(
                              image: AssetImage("assets/big-message-icon.png"),
                            )
                          : const Image(
                              image: AssetImage("assets/sms-tracking-icon.png"),
                            ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        _isDone == true
                            ? "Xác thực OTP"
                            : "Nhập địa chỉ email mới",
                        style: AppTextStyle.lato.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                            color: const Color(0xFF58583A)),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCF6F6),
                          // .withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                _isValidEmail == null && _isOldEmail == null ||
                                        _isOldEmail == false &&
                                            _isValidEmail == true
                                    ? const Color(0xFFD9D9D9)
                                    : Colors.red,
                            width: 1,
                          ),
                        ),
                        child: _isDone == true
                            ? Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Form(
                                  key: _otpFormKey,
                                  child: TextFormField(
                                    controller: otpController,
                                    textAlign: TextAlign.center,
                                    readOnly: _isExpired == true ? true : false,
                                    style: const TextStyle(fontSize: 18),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6)
                                    ],
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.length < 6) {
                                          setState(() {
                                            _isValidOTP = false;
                                          });
                                          return '';
                                        }
                                      }
                                      setState(() {
                                        _isValidOTP = true;
                                      });
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Nhập mã OTP",
                                      border: InputBorder.none,
                                      errorStyle: TextStyle(height: 0),
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Form(
                                  key: _emailFormKey,
                                  child: TextFormField(
                                    controller: _emailController,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18),
                                    onChanged: (value) => {
                                      setState(() {
                                        _isOldEmail =
                                            (widget.mdUser!.email == value)
                                                ? true
                                                : false;
                                        _isValidEmail = value.isValidEmail();
                                      })
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      border: InputBorder.none,
                                      errorStyle: TextStyle(height: 0),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: height * 0.007,
                      ),
                      if (_isValidOTP == false && _isExpired == false ||
                          user.isValidOTPProvider == false &&
                              _isExpired == false)
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Mã OTP không đúng, vui lòng nhập lại",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.Red,
                            ),
                          ),
                        ),
                      if (_isOldEmail != true)
                        if (_isValidEmail == false)
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Email không hợp lệ",
                              style: AppTextStyle.lato.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.Red,
                              ),
                            ),
                          ),
                      if (_isOldEmail == true)
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Email mới không được trùng với email cũ",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.Red,
                            ),
                          ),
                        ),
                      if (_isDone == true)
                        Column(
                          children: [
                            if (!_isExpired)
                              Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  SizedBox(
                                    width: width * 0.7,
                                    child: Text(
                                      "Vui lòng kiểm tra địa chỉ email của bạn để nhận mã OTP",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.lato.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF140E09),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                ],
                              ),
                            if (_isExpired)
                              Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      otpController.clear();
                                      _isValidOTP = true;
                                      user.setIsValidOTP(true);
                                      Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .sendOTPToChangeEmail(
                                              _emailController.text, context);
                                      startTimer();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Chưa nhận được mã OTP? ",
                                        style: AppTextStyle.lato.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF140E09),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Gửi lại",
                                            style: AppTextStyle.lato.copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFFFE2C6B),
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (!_isExpired)
                              RichText(
                                text: TextSpan(
                                  text: "Bạn có thể gửi lại mã OTP sau ",
                                  style: AppTextStyle.lato.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF140E09),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "$min:$sec",
                                      style: AppTextStyle.lato.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFFBEBAB7),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      if (_isValidEmail == true &&
                          _isDone != true &&
                          _isOldEmail != true)
                        user.isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.DarkPink,
                              )
                            : Container(
                                width: width,
                                decoration: BoxDecoration(
                                  color: AppColors.RedTheme,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .sendOTPToChangeEmail(
                                              _emailController.text, context);
                                      print("ok");
                                      setState(() {
                                        _isDone = true;
                                      });
                                      startTimer();
                                    },
                                    splashColor: Colors.grey,
                                    child: Center(
                                      child: Text(
                                        "Tiếp tục",
                                        style: AppTextStyle.lato.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      if (_isDone == true && _isExpired == false)
                        user.isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.DarkPink,
                              )
                            : Container(
                                width: width,
                                decoration: BoxDecoration(
                                  color: AppColors.RedTheme,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      if (_otpFormKey.currentState!
                                          .validate()) {
                                        Provider.of<ProfileProvider>(context,
                                                listen: false)
                                            .checkOTP(
                                                context,
                                                otpController.text,
                                                user.mdUser,
                                                _emailController.text);
                                        print(user.isValidOTPProvider);
                                      }
                                    },
                                    splashColor: Colors.grey,
                                    child: Center(
                                      child: Text(
                                        "Hoàn thành",
                                        style: AppTextStyle.lato.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

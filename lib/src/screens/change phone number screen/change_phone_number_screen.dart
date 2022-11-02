import 'dart:async';

import "package:flutter/material.dart";
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  MDUser? mdUser;
  ChangePhoneNumberScreen({Key? key, this.mdUser}) : super(key: key);
  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  }

  bool _isExpired = true, _isOTPSent = false;
  bool? _isValidOTP, _isWaiting, _isValidPhoneNumber;
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  ProfileProvider? profileProvider;
  final TextEditingController phoneNumberController = TextEditingController();
  String? otp;
  int min = 0, sec = 30;
  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      if (min == 0 && sec == 0) {
        setState(() {
          timer.cancel();
          _isWaiting = false;
          min = 0;
          sec = 15;
        });
      } else {
        setState(() {
          if (min > 0 && sec == 0) {
            min--;
            sec = 60;
          }
          sec--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage("assets/login-screen-background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.White,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Text(
                              "Nhập số điện thoại mới",
                              style: AppTextStyle.lato.copyWith(
                                fontSize: 22,
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
                                fontSize: 22,
                                color: AppColors.White,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        height: height * 0.095,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          color: AppColors.White.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.Black.withOpacity(0.5),
                            width: 1,
                          ),
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
                              TextField(
                                textAlign: TextAlign.center,
                                controller: phoneNumberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(0),
                                  hintText: "Nhập số điện thoại",
                                  hintStyle: AppTextStyle.lato.copyWith(
                                    fontSize: 18,
                                    color: AppColors.Black.withOpacity(0.5),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      InkWell(
                        hoverColor: AppColors.Grey,
                        onTap: () => {
                          print("ok"),
                        },
                        child: InkWell(
                          onTap: () {
                            // use StringExtension to check phonenubmer

                            if (phoneNumberController.text
                                .isValidPhoneNumber()) {
                              _isValidPhoneNumber = true;
                              if (_isWaiting == null || _isWaiting == false) {
                                startTimer();
                                profileProvider!.sendOTPToChangePhoneNumber(
                                    widget.mdUser!, context);
                                setState(() {
                                  _isOTPSent = true;
                                  _isWaiting = true;
                                });
                              }
                            } else {
                              _isValidPhoneNumber = false;
                            }
                          },
                          child: Column(
                            children: [
                              if (_isValidPhoneNumber == false)
                                Text(
                                  "Số điện thoại không hợp lệ",
                                  style: AppTextStyle.lato.copyWith(
                                    fontSize: 14,
                                    color: AppColors.Red,
                                  ),
                                ),
                              if (_isValidPhoneNumber == false)
                                SizedBox(
                                  height: height * 0.001,
                                ),
                              if (_isOTPSent == false)
                                ButtonContainer(
                                  height: height,
                                  width: width,
                                  text: "Gửi mã OTP",
                                  color: const Color(0xFF5FC5FF),
                                ),
                              if (_isOTPSent == true && _isWaiting == true)
                                ButtonContainer(
                                  height: height,
                                  width: width,
                                  text: sec / 10 == 0
                                      ? "0$min:0$sec"
                                      : "0$min:$sec",
                                  color: const Color(0xFFCDCDCD),
                                ),
                              if (_isOTPSent == true && _isWaiting == false)
                                ButtonContainer(
                                  height: height,
                                  width: width,
                                  text: "Gửi lại OTP",
                                  color: const Color(0xFF5FC5FF),
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (_isOTPSent)
                        Column(
                          children: [
                            SizedBox(
                              height: height * 0.08,
                            ),
                            if (_isOTPSent == true && _isValidOTP == null)
                              SizedBox(
                                width: width * 0.7,
                                child: Text(
                                  _isWaiting == true
                                      ? "Đã gửi OTP, vui lòng check trong hộp thư Email của bạn và điền mã OTP vào ô dưới đây"
                                      : "OTP đã hết hạn, vui lòng gửi lại OTP",
                                  style: AppTextStyle.lato.copyWith(
                                      fontSize: 13, color: AppColors.Red),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            if (_isOTPSent == true && _isValidOTP == false)
                              Text(
                                "OTP không đúng",
                                style: AppTextStyle.lato.copyWith(
                                    fontSize: 13, color: AppColors.Red),
                                textAlign: TextAlign.center,
                              ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Container(
                              height: height * 0.08,
                              width: width * 0.85,
                              decoration: BoxDecoration(
                                color: AppColors.White.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.Grey,
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: Form(
                                  key: _otpFormKey,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6)
                                    ],
                                    onChanged: (value) => otp = value,
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
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            InkWell(
                              onTap: () {
                                if (_isWaiting == true && _isWaiting != null) {
                                  if (min == 0 && sec == 0) {
                                  } else {
                                    _otpFormKey.currentState!.validate();
                                    if (_isValidOTP == true &&
                                        _isOTPSent == true &&
                                        phoneNumberController.text.isNotEmpty) {
                                      profileProvider!.changePhoneNumber(
                                          context,
                                          widget.mdUser,
                                          phoneNumberController.text);
                                    }
                                  }
                                }
                              },
                              child: ButtonContainer(
                                  height: height,
                                  width: width,
                                  text: "Xác thực",
                                  color: _isWaiting == false
                                      ? const Color(0xFFCDCDCD)
                                      : AppColors.White),
                            ),
                          ],
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.color,
  }) : super(key: key);
  final String text;
  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.05,
      width: width * 0.45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.Grey,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyle.lexendExa.copyWith(
            fontSize: 16,
            color: AppColors.Black,
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/otp_provider.dart';
import 'package:untitled/src/providers/reset_password_provider.dart';
import '../../../utils/app_constant/app_colors.dart';
import '../../providers/register_provider.dart';

class RegisterOTPScreen extends StatefulWidget {
  final MDUser? mdUser;
  final String? type;
  final String? email;
  const RegisterOTPScreen({Key? key, this.mdUser, this.type, this.email})
      : super(key: key);

  @override
  State<RegisterOTPScreen> createState() => _RegisterOTPScreenState();
}

class _RegisterOTPScreenState extends State<RegisterOTPScreen> {
  OTPProvider? otpProvider;
  RegisterProvider? provider;
  ResetPasswordProvider? forgetPwOtpProvider;
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  Timer? timer;
  int min = 1, sec = 59;
  bool isWaiting = true;
  @override
  void initState() {
    super.initState();
    otpProvider = Provider.of<OTPProvider>(context, listen: false);
    provider = Provider.of<RegisterProvider>(context, listen: false);
    forgetPwOtpProvider =
        Provider.of<ResetPasswordProvider>(context, listen: false);
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    provider!.reset();
    super.dispose();
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (timer) {
      if (min == 0 && sec == 0) {
        setState(() {
          timer.cancel();
          isWaiting = false;

          min = 1;
          sec = 59;
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

  void showLoading() {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void handleOTPSent() {
    Navigator.of(context).pop();
    isWaiting = true;
    startTimer();
    if (widget.type == 'forget') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Đã gửi OTP')));
    }
  }

  void handleResent() {
    switch (widget.type) {
      case 'forget':
        if (!isWaiting) {
          showLoading();
          forgetPwOtpProvider!
              .sendPasswordResetOTP(widget.email!)
              .then((_) => handleOTPSent());
        }
        break;
      default:
        if (!isWaiting) {
          showLoading();
          otpProvider!
              .sendOTP(widget.mdUser!, context)
              .then((value) => handleOTPSent());
        }
    }
  }

  void handleValidate() {
    switch (widget.type) {
      case 'forget':
        if (_otpFormKey.currentState!.validate()) {
          setState(() {});
          showLoading();
          forgetPwOtpProvider!.checkPasswordResetOTP(
              widget.email!, otpController.text, context);
        }
        break;
      default:
        if (_otpFormKey.currentState!.validate()) {
          setState(() {});
          showLoading();
          provider!.register(widget.mdUser!, otpController.text, context);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final data;
    if (widget.type == 'forget') {
      data = Provider.of<ResetPasswordProvider>(context);
    } else {
      data = Provider.of<RegisterProvider>(context);
    }

    return Scaffold(
      backgroundColor: AppColors.White,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              color: AppColors.LightPurple,
              child: SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 33),
                      child: Center(
                        child: Image.asset(
                          'assets/otp-screen-decoration.png',
                          width: width * 0.34,
                        ),
                      ),
                    ),
                    IconButton(
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(22),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: SvgPicture.asset('assets/back.svg'))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 37, right: 37, top: 34, bottom: 37),
                child: Column(
                  children: [
                    const Text(
                      'Xác thực OTP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Color(0xFF58583A)),
                    ),
                    SizedBox(height: height * 0.074),
                    Form(
                        key: _otpFormKey,
                        child: TextFormField(
                          controller: otpController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 6,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              setState(() {
                                data.otpError = 'Vui lòng nhập OTP';
                              });
                              return '';
                            }
                            setState(() {
                              data.otpError = '';
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 25),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.2))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: data.otpError.isNotEmpty
                                    ? const BorderSide(color: AppColors.Red)
                                    : BorderSide(
                                        color: Colors.black.withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: data.otpError.isNotEmpty
                                        ? AppColors.Red
                                        : Colors.black.withOpacity(0.2))),
                            counterText: "",
                            errorStyle: const TextStyle(height: 0),
                          ),
                        )),
                    if (data.otpError != '')
                      Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Text(data.otpError,
                              style: GoogleFonts.inter(
                                  color: const Color(0xFFFF0000),
                                  fontSize: 12)),
                        ],
                      ),
                    SizedBox(height: height * 0.05),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: const Text(
                        'Đã gửi OTP đến số điện thoại/ email mà bạn đã đăng ký',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.Purple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: isWaiting
                                  ? const Color(0xFFBEBAB7).withOpacity(0.8)
                                  : AppColors.LightPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              fixedSize: const Size.fromHeight(48),
                              shadowColor: Colors.transparent),
                          onPressed: () {
                            handleResent();
                          },
                          child: Text(
                            isWaiting ? '$min:$sec' : 'Gửi lại',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          )),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          handleValidate();
                        },
                        child: const Text(
                          'Xác thực',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.Purple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            fixedSize: const Size.fromHeight(48),
                            shadowColor: Colors.transparent),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

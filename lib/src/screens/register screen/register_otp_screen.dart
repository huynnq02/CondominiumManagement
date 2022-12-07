import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/otp_provider.dart';
import 'package:untitled/src/widget/outlined_text.dart';
import '../../../utils/app_constant/app_colors.dart';
import '../../providers/register_provider.dart';

class RegisterOTPScreen extends StatefulWidget {
  MDUser mdUser;
  RegisterOTPScreen({Key? key, required this.mdUser}) : super(key: key);

  @override
  State<RegisterOTPScreen> createState() => _RegisterOTPScreenState();
}

class _RegisterOTPScreenState extends State<RegisterOTPScreen> {
  OTPProvider? otpProvider;
  RegisterProvider? provider;
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
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final data = Provider.of<RegisterProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: AppColors.White,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.asset('assets/otp-screen-bg.png',
                        fit: BoxFit.fill)),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.only(
                      top: 24, bottom: 100, left: 36, right: 41),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/otp-screen-decoration.png',
                        width: width * 0.5,
                      ),
                      OutlinedText(
                        text: 'Xác thực OTP',
                        fontSize: 24,
                        color: Colors.black,
                        strokeColor: Colors.black.withOpacity(0.2),
                      ),
                      SizedBox(height: height * 0.075),
                      Form(
                          key: _otpFormKey,
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4)
                                  ],
                                  color: Colors.white),
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
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: data.otpError.isNotEmpty
                                          ? const BorderSide(
                                              color: AppColors.Red)
                                          : const BorderSide()),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: data.otpError.isNotEmpty
                                              ? AppColors.Red
                                              : AppColors.DarkBlue,
                                          width: 2)),
                                  counterText: "",
                                  errorStyle: const TextStyle(height: 0),
                                ),
                              ),
                            ),
                            if (data.otpError != '')
                              Positioned(
                                  top: 3,
                                  child: Text(data.otpError,
                                      style: GoogleFonts.inter(
                                          color: const Color(0xFFFF0000),
                                          fontSize: 9))),
                          ])),
                      SizedBox(height: height * 0.05),
                      SizedBox(
                        width: 173,
                        height: 34,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isWaiting
                                  ? const Color(0xFFCDCDCD)
                                  : const Color(0xFF5FC5FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (!isWaiting) {
                                showLoading();
                                otpProvider!
                                    .sendOTP(widget.mdUser, context)
                                    .then((value) => handleOTPSent());
                              }
                            },
                            child: Text(
                              isWaiting ? '$min:$sec' : 'Gửi lại',
                              style: GoogleFonts.lexendExa(
                                  fontSize: 16,
                                  color:
                                      isWaiting ? Colors.black : Colors.white),
                            )),
                      ),
                      SizedBox(height: height * 0.03),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48),
                        child: Text(
                          'Đã gửi OTP đến số điện thoại/ email mà bạn đã đăng ký',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.Red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 185,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_otpFormKey.currentState!.validate()) {
                              setState(() {});
                              showLoading();
                              inspect(widget.mdUser);
                              provider!.register(
                                  widget.mdUser, otpController.text, context);
                            }
                          },
                          child: OutlinedText(
                            text: 'Xác thực',
                            fontSize: 16,
                            style: GoogleFonts.lexendExa(),
                            color: Colors.white,
                            strokeColor: Colors.white.withOpacity(0.5),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.DarkBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(23),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/back.svg',
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ));
  }
}

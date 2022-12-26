import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/otp_provider.dart';
import 'package:untitled/src/providers/reset_password_provider.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_button.dart';
import 'package:untitled/src/screens/register%20screen/register_info_screen.dart';
import '../../../utils/app_constant/app_colors.dart';

class RegisterOTPScreen extends StatefulWidget {
  final MDUser? mdUser;
  final String? type;
  final String? email;
  final String? phoneNumber;
  final String password;
  final String? verificationId;
  const RegisterOTPScreen(
      {Key? key,
      this.mdUser,
      this.type,
      this.email,
      this.phoneNumber,
      this.verificationId,
      required this.password})
      : super(key: key);

  @override
  State<RegisterOTPScreen> createState() => _RegisterOTPScreenState();
}

class _RegisterOTPScreenState extends State<RegisterOTPScreen> {
  OTPProvider? otpProvider;
  ResetPasswordProvider? forgetPwOtpProvider;
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  Timer? timer;
  int min = 1, sec = 59;
  bool isWaiting = true;
  String? verificationId;
  @override
  void initState() {
    super.initState();
    if (widget.verificationId != null) {
      verificationId = widget.verificationId;
    }
    otpProvider = Provider.of<OTPProvider>(context, listen: false);
    forgetPwOtpProvider =
        Provider.of<ResetPasswordProvider>(context, listen: false);
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    otpProvider!.reset();
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
            child: CircularProgressIndicator(
              color: AppColors.DarkPink,
            ),
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

  void handleResent() async {
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
          if (verificationId != null) {
            showLoading();
            await otpProvider!.retrySendSMSOTP(
                context,
                widget.phoneNumber!,
                widget.password,
                (value) => verificationId = value,
                () => handleOTPSent());
          } else {
            otpProvider!
                .sendEmailOTP(widget.email!, widget.password, context)
                .then((value) => handleOTPSent());
          }
        }
    }
  }

  void handleValidate() async {
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
          if (verificationId != null) {
            showLoading();
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId!,
              smsCode: otpController.text,
            );
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterInfoScreen(
                  email: widget.phoneNumber!,
                  password: widget.password,
                  isEmail: false,
                ),
              ));
            }).onError((error, stackTrace) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP không đúng.')));
            });
          } else {
            otpProvider!.confirmEmailOTP(widget.email!,widget.password, otpController.text, context);
          }
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
      data = Provider.of<OTPProvider>(context);
    }

    return Scaffold(
      backgroundColor: AppColors.White,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.DarkPink,
        toolbarHeight: 60,
        title: const Text(
          'Xác thực OTP',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFFFCF6F6)),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              'assets/back.svg',
              height: 24,
            )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 37, vertical: height * 0.054),
        child: Column(
          children: [
            SvgPicture.asset('assets/otp-screen-decoration.svg'),
            const SizedBox(
              height: 29,
            ),
            const Text(
              'Xác thực OTP',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 25),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: data.otpError.isNotEmpty
                            ? const BorderSide(color: AppColors.Red)
                            : const BorderSide(color: Color(0xFFD9D9D9))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: data.otpError.isNotEmpty
                                ? AppColors.Red
                                : const Color(0xFFD9D9D9))),
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
                          color: const Color(0xFFFF0000), fontSize: 12)),
                ],
              ),
            SizedBox(height: height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: const Text(
                'Vui lòng kiểm tra email hoặc điện thoại của bạn để nhận mã OTP',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF140E09),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 29,
            ),
            isWaiting
                ? RichText(
                    text: TextSpan(
                      text: 'Bạn có thể gửi lại mã OTP sau ',
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: '$min:$sec',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFBEBAB7)))
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () => handleResent(),
                    child: const Text(
                      'Gửi mã OTP',
                      style: TextStyle(
                          color: AppColors.Pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                    ),
                  ),
            const Spacer(),
            CustomButton(onPressed: () => handleValidate(), label: 'Xác thực')
          ],
        ),
      ),
    );
  }
}

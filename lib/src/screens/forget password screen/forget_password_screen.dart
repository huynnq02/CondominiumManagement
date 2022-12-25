import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/reset_password_provider.dart';
import 'package:untitled/src/screens/register%20screen/register_otp_screen.dart';
import 'package:untitled/src/widget/outlined_text.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ResetPasswordProvider? provider;
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  Timer? timer;
  int min = 1, sec = 59;
  bool isWaiting = false;
  late String email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<ResetPasswordProvider>(context, listen: false);
  }

  @override
  void dispose() {
    timer?.cancel();
    provider!.reset();
    super.dispose();
  }

  void startTimer(ResetPasswordProvider data) {
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

  void handleOTPSent(ResetPasswordProvider data) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Đã gửi OTP')));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegisterOTPScreen(type: 'forget',email: email,password: 'null',)));
  }

  bool isEmail(String input) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);

  bool isPhone(String input) =>
      RegExp(r'(^(?:[+0]9)?[0-9]{10,11}$)').hasMatch(input);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ResetPasswordProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.White,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: AppColors.LightPurple,
              child: SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 54, horizontal: width * 0.18),
                      child: Center(
                        child: OutlinedText(
                          text:
                              'Nhập email hoặc số điện thoại dùng đăng kí app để nhận mã OTP',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
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
            const SizedBox(
              height: 95,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.09),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        data.emailError,
                        style: GoogleFonts.inter(
                            color: data.emailError.isNotEmpty
                                ? AppColors.Red
                                : Colors.transparent,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                  Form(
                    key: _emailKey,
                    child: TextFormField(
                      controller: emailController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      style: const TextStyle(fontSize: 18),
                      maxLength: 50,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            data.emailError = 'Vui lòng nhập email';
                          });
                          return '';
                        }
                        final isNum = num.tryParse(value) is num;
                        if (!isNum) {
                          if (!isEmail(value)) {
                            setState(() {
                              data.emailError =
                                  'Định dạng email không đúng, vui lòng nhập lại';
                            });
                            return '';
                          }
                        } else {
                          if (!isPhone(value) || !value.startsWith('0')) {
                            setState(() {
                              data.emailError =
                                  'Định dạng không hợp lệ, vui lòng nhập lại';
                            });
                            return '';
                          }
                        }
                        setState(() {
                          data.emailError = '';
                        });
                        return null;
                      },
                      decoration: InputDecoration(
                          counterText: '',
                          hintText: 'Nhập email',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Color(0xFFFF0000)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Color(0xFFFF0000)),
                          ),
                          errorStyle: const TextStyle(height: 0),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 17)),
                    ),
                  ),
                  const SizedBox(
                    height: 95,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.Purple,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4),
                        onPressed: () {
                          if (_emailKey.currentState!.validate()) {
                            showLoading();
                            email = emailController.text;
                            provider!
                                .sendPasswordResetOTP(email)
                                .then((_) => handleOTPSent(data));
                          }
                        },
                        child: const Text(
                          'Gửi mã OTP',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

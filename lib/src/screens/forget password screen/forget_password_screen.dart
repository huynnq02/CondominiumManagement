import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/reset_password_provider.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_button.dart';
import 'package:untitled/src/screens/register%20screen/register_otp_screen.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/helper/show_snack_bar.dart';

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
            child: CircularProgressIndicator(
              color: AppColors.DarkPink,
            ),
          );
        });
  }

  bool isEmail(String input) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);

  bool isPhone(String input) =>
      RegExp(r'(^(?:[+0]9)?[0-9]{10,11}$)').hasMatch(input);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ResetPasswordProvider>(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.DarkPink,
        toolbarHeight: 60,
        title: const Text(
          'Quên mật khẩu',
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
      backgroundColor: AppColors.White,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 38, vertical: height * 0.05),
        child: Column(
          children: [
            SvgPicture.asset('assets/forget-pw-decoration.svg'),
            SizedBox(
              height: height * 0.027,
            ),
            const Text(
              'Nhập email hoặc số điện thoại đăng nhập tài khoản để nhận mã OTP',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF58583A)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.041,
            ),
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
                    hintText: 'Email / Số điện thoại',
                    hintStyle:
                        const TextStyle(fontSize: 18, color: Color(0xFFBBBBBB)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFFF0000)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFFF0000)),
                    ),
                    errorStyle: const TextStyle(height: 0),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20)),
              ),
            ),
            const Spacer(),
            CustomButton(
                onPressed: () {
                  if (_emailKey.currentState!.validate()) {
                    showLoading();
                    if (isEmail(emailController.text)) {
                      email = emailController.text;
                      provider!
                          .sendPasswordResetOTP(email, context);
                    } else {
                      provider!.sendSMSOTP(context, emailController.text);
                    }
                  }
                },
                label: 'Tiếp tuc')
          ],
        ),
      ),
    );
  }
}

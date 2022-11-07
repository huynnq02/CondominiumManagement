import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/src/widget/outlined_text.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _OTPKey = GlobalKey<FormState>();
  bool isOTPSent = false;
  String emailError = '';
  String otpError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/register_bg.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter),
      ),
      child: SafeArea(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 50),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 254,
                      child: OutlinedText(
                        text: 'Nhập email dùng đăng kí app để nhận mã OTP',
                        fontSize: 24,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 51,
                    ),
                    if (emailError.isNotEmpty)
                      Column(
                        children: [
                          Text(
                            emailError,
                            style: GoogleFonts.inter(
                                color: AppColors.Red, fontSize: 12),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    Form(
                      key: _emailKey,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.black,
                        style: const TextStyle(fontSize: 18),
                        maxLength: 50,
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              emailError = 'Vui lòng nhập email';
                            });
                            return '';
                          }
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@gmail.com$';
                          RegExp regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            setState(() {
                              emailError = 'Email không hợp lệ';
                            });
                            return '';
                          }
                          setState(() {
                            emailError = '';
                          });
                          return null;
                        },
                        decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Color(0xFF5FC5FF), width: 2.0),
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
                      height: 69,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5FC5FF),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 37, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4),
                        onPressed: () {
                          if (_emailKey.currentState!.validate()) {
                            setState(() {
                              isOTPSent = true;
                            });
                          }
                        },
                        child: Text(
                          'Gửi mã OTP',
                          style: GoogleFonts.lexendExa(
                              fontSize: 16, color: Colors.black),
                        )),
                    if (isOTPSent)
                      Column(
                        children: [
                          const SizedBox(
                            height: 51,
                          ),
                          const SizedBox(
                            width: 254,
                            child: Text(
                              'Đã gửi OTP, vui lòng check trong hộp thư của bạn và điền mã OTP vào ô dưới đây',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFFFF0000), fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          if (otpError.isNotEmpty)
                            Column(
                              children: [
                                Text(
                                  otpError,
                                  style: GoogleFonts.inter(
                                      color: AppColors.Red, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          Form(
                            key: _OTPKey,
                            child: Material(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xFFF8F6FD),
                              elevation: 4,
                              shadowColor: Colors.black,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                style: const TextStyle(fontSize: 18),
                                maxLength: 6,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      otpError = 'Vui lòng nhập mã OTP';
                                    });
                                    return '';
                                  }
                                  setState(() {
                                    otpError = '';
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                    counterText: '',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFFF0000)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFFF0000)),
                                    ),
                                    errorStyle: const TextStyle(height: 0),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 26)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 77,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_OTPKey.currentState!.validate()) {}
                            },
                            child: Text(
                              'Xác nhận',
                              style: GoogleFonts.lexendExa(
                                  fontSize: 16, color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 47, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4),
                          ),
                        ],
                      ),
                  ],
                ),
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
        ]),
      ),
    ));
  }
}

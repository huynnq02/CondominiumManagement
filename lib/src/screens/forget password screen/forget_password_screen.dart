import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/src/widget/outlined_text.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 50),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                      TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.black,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
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
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 17)),
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
                          onPressed: () {},
                          child: Text(
                            'Gửi mã OTP',
                            style: GoogleFonts.lexendExa(
                                fontSize: 16, color: Colors.black),
                          )),
                      const SizedBox(
                        height: 51,
                      ),
                      const SizedBox(
                        width: 254,
                        child: Text(
                          'Đã gửi OTP, vui lòng check trong hộp thư của bạn và điền mã OTP vào ô dưới đây',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFFFF0000), fontSize: 13),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFF8F6FD),
                        elevation: 4,
                        shadowColor: Colors.black,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 26)),
                        ),
                      ),
                      const SizedBox(
                        height: 77,
                      ),
                      ElevatedButton(
                        onPressed: () {},
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

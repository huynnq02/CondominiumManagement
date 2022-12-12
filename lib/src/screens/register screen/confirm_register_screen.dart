import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/widget/register_textfield.dart';
import '../../../utils/app_constant/app_colors.dart';
import '../../providers/register_provider.dart';

class ConfirmRegisterScreen extends StatefulWidget {
  MDUser mdUser;
  ConfirmRegisterScreen({Key? key, required this.mdUser}) : super(key: key);

  @override
  State<ConfirmRegisterScreen> createState() => _ConfirmRegisterScreenState();
}

class _ConfirmRegisterScreenState extends State<ConfirmRegisterScreen> {
  RegisterProvider? provider;
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    provider = Provider.of<RegisterProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
          color: AppColors.White,
          child: Form(
            key: _otpFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 44,
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      child: Text('ĐĂNG KÝ',
                          style: TextStyle(
                              fontSize: 31,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: const Offset(0, 4),
                                    blurRadius: 4)
                              ],
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: <Color>[
                                    Color.fromRGBO(0, 28, 68, 1),
                                    Color.fromRGBO(0, 28, 68, 0.76)
                                  ],
                                ).createShader(const Rect.fromLTWH(
                                    0.0, 0.0, 114.0, 37.0)))),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 23,
                        ),
                        Image.asset(
                          'assets/register_logo.png',
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Hãy kiểm tra thiết bị của bạn để nhập mã OTP',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          const SizedBox(height: 30),
                          RegisterTextField(
                            labelText: 'Nhập mã OTP',
                            type: TextFieldType.number,
                            maxLength: 6,
                            isCenter: true,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (value) {
                              if (value != null) {
                                if (value.length < 6) {
                                  return 'Vui lòng nhập đủ 6 ký tự';
                                }
                              }
                              return null;
                            },
                          )
                        ]),
                  ),
                ),
                Stack(alignment: Alignment.topCenter, children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/clouds.png',
                            fit: BoxFit.fitWidth,
                          )),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        _otpFormKey.currentState!.validate();
                      },
                      child: Image.asset('assets/register_button.png'))
                ])
              ],
            ),
          ),
        )));
  }
}

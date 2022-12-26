import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/otp_provider.dart';
import 'package:untitled/src/providers/register_provider.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_button.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_textfield.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

const List<String> genderList = <String>['Nam', 'Nữ'];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterProvider? provider;
  OTPProvider? otpProvider;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool? checkBoxValue = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RegisterProvider>(context, listen: false);
    otpProvider = Provider.of<OTPProvider>(context, listen: false);
  }

  @override
  void dispose() {
    otpProvider!.reset();
    super.dispose();
  }

  bool isEmail(String input) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);

  bool isPhone(String input) =>
      RegExp(r'(^(?:[+0]9)?[0-9]{10,11}$)').hasMatch(input);

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color(0xFF323232),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        content: Text(
          'Chức năng đang được phát triển, vui lòng truy cập lại sau!',
          style: TextStyle(fontSize: 13, color: Colors.white),
          textAlign: TextAlign.center,
        )));
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OTPProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.White,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 39, vertical: height * 0.05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.109,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nhập thông tin đăng ký tài khoản.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        controller: emailController,
                        labelText: 'Email/ Số điện thoại',
                        type: TextFieldType.email,
                        error: data.emailError,
                        maxLength: 50,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        labelText: 'Mật khẩu',
                        type: TextFieldType.password,
                        maxLength: 20,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Text(
                        'Hoặc tiếp tục với',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(0xFF7D8387)),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () => showSnackBar(),
                              child:
                                  SvgPicture.asset('assets/facebook-btn.svg')),
                          SizedBox(
                            width: width * 0.07,
                          ),
                          InkWell(
                              onTap: () => showSnackBar(),
                              child: SvgPicture.asset('assets/google.svg')),
                          SizedBox(
                            width: width * 0.07,
                          ),
                          InkWell(
                              onTap: () => showSnackBar(),
                              child:
                                  SvgPicture.asset('assets/apple.svg')), /*  */
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor:
                                    const Color(0xFFD6D6D6), // Your color
                              ),
                              child: Checkbox(
                                  activeColor: AppColors.DarkPink,
                                  value: checkBoxValue,
                                  onChanged: ((value) {
                                    setState(() {
                                      checkBoxValue = value;
                                    });
                                  })),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Expanded(
                              flex: 15,
                              child: RichText(
                                text: const TextSpan(
                                  text:
                                      'Bằng việc sử dụng Apato, bạn đồng ý rằng bạn đã đọc và chấp nhận ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Điều khoản',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        )),
                                    TextSpan(text: ' của chúng tôi'),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: height * 0.0236,
                      ),
                      CustomButton(
                        label: 'Tiếp tục',
                        disabled: !checkBoxValue!,
                        onPressed: () {
                          setState(() {
                            data.emailError = '';
                          });
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isError = false;
                            });
                            if (isEmail(emailController.text)) {
                              otpProvider!.sendEmailOTP(emailController.text,
                                  passwordController.text, context);
                            } else {
                              provider!.checkPhoneExistence(
                                context,
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          } else {
                            setState(() {
                              isError = true;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(22),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/back.svg',
                    color: const Color(0xFF979A9C),
                  ))
            ],
          ),
        ));
  }
}

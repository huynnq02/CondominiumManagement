import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/otp_provider.dart';
import 'package:untitled/src/providers/register_provider.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_button.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_textfield.dart';
import 'package:untitled/src/screens/register%20screen/register_info_screen.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool? checkBoxValue = false;
  bool isError = false;
  String confirmErr = '';

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RegisterProvider>(context, listen: false);
  }

  @override
  void dispose() {
    provider!.reset();
    super.dispose();
  }

  bool isEmail(String input) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);

  bool isPhone(String input) =>
      RegExp(r'(^(?:[+0]9)?[0-9]{10,11}$)').hasMatch(input);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<RegisterProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.White,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 28),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Đăng ký',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Color(0XFF58583A)),
                    ),
                    const SizedBox(
                      height: 39,
                    ),
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email/ Số điện thoại',
                      type: TextFieldType.email,
                      error: data.emailError,
                      maxLength: 50,
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      labelText: 'Mật khẩu',
                      type: TextFieldType.password,
                      maxLength: 20,
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    CustomTextField(
                      controller: confirmPasswordController,
                      labelText: 'Nhập lại mật khẩu',
                      type: TextFieldType.password,
                      error: confirmErr,
                      pwRule: false,
                      maxLength: 20,
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor:
                                  const Color(0xFFD6D6D6), // Your color
                            ),
                            child: Checkbox(
                                activeColor: Colors.black,
                                value: checkBoxValue,
                                onChanged: ((value) {
                                  setState(() {
                                    checkBoxValue = value;
                                  });
                                })),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Expanded(
                            flex: 15,
                            child: RichText(
                              text: const TextSpan(
                                text:
                                    'Bằng việc sử dụng Apato, bạn đồng ý rằng bạn đã đọc và chấp nhận ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Điều khoản',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      )),
                                  TextSpan(text: ' của chúng tôi'),
                                ],
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    CustomButton(
                      label: 'Tiếp tục',
                      onPressed: () {
                        setState(() {});
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            data.emailError = '';
                            isError = false;
                          });
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            setState(() {
                              confirmErr = '';
                            });
                            if (checkBoxValue == true) {
                              if (isEmail(emailController.text)) {
                                provider!.checkEmailExistence(
                                  context,
                                  emailController.text,
                                  passwordController.text,
                                );
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => RegisterInfoScreen(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          isEmail: false,
                                        ))));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Vui lòng chấp nhận điều khoản.')));
                            }
                          } else {
                            setState(() {
                              confirmErr = 'Mật khẩu không khớp';
                            });
                          }
                        } else {
                          setState(() {
                            isError = true;
                          });
                        }
                      },
                      disabled: isError,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

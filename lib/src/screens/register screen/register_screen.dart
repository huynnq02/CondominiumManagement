import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/register_provider.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_constant/app_colors.dart';
import '../../widget/register_textfield.dart';

const List<String> genderList = <String>['Nam', 'Nữ', 'Khác'];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterProvider? provider;
  MDUser mdUser = MDUser();
  String? password;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<RegisterProvider>(context, listen: false);
  }

  String dropdownValue = genderList.first;

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: AppColors.White,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                              ).createShader(
                                  const Rect.fromLTWH(0.0, 0.0, 114.0, 37.0)))),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: RegisterTextField(
                            labelText: 'Email',
                            type: TextFieldType.email,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(25),
                            elevation: 4,
                            shadowColor: Colors.black,
                            child: DropdownButtonFormField(
                              borderRadius: BorderRadius.circular(25),
                              value: dropdownValue,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.56))),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 18),
                                // labelText: 'Giới tính',
                                // labelStyle: const TextStyle(
                                //   color: Color.fromRGBO(99, 99, 99, 1),
                                // ),
                              ),
                              items: genderList
                                  .map<DropdownMenuItem<String>>((value) =>
                                      DropdownMenuItem(
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: dropdownCallback,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    const RegisterTextField(
                      labelText: 'Nhập mật khẩu',
                      type: TextFieldType.password,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    const RegisterTextField(
                      labelText: 'Nhập lại mật khẩu',
                      type: TextFieldType.password,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    const RegisterTextField(labelText: 'Nhập Họ và Tên'),
                    const SizedBox(
                      height: 22,
                    ),
                    Row(
                      children: const [
                        Expanded(
                            child: RegisterTextField(
                              labelText: 'Ngày sinh',
                              type: TextFieldType.date,
                            ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: RegisterTextField(
                            labelText: 'Số CCCD/CMND',
                            type: TextFieldType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Image.asset('assets/register_avatar.png'),
                    const SizedBox(
                      height: 22,
                    )
                  ],
                ),
              ),
              Stack(alignment: Alignment.topCenter, children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 22,
                    ),
                    Image.asset('assets/clouds.png'),
                  ],
                ),
                Image.asset('assets/register_otp_button.png')
              ])
            ],
          ),
        ),
      ),
    )));
  }
}

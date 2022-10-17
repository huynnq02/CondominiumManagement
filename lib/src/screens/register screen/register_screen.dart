import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/register_provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../../widget/register_textfield.dart';
import '../login screen/login_screen.dart';
import 'widget/widget_button.dart';

const List<String> genderList = <String>['Nam', 'Nữ', 'Khác'];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  RegisterProvider? provider;
  String? password;
  String dropdownValue = genderList.first;
  File? avatar;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  bool? checkBoxValue = false;
  bool? showError = false;
  bool? isValid = false;
  bool? validOTP;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RegisterProvider>(context, listen: false);
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue = selectedValue;
      });
    }
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      //Crop image
      File? tempImage = File(image.path);
      tempImage = await cropImage(imageFile: tempImage);

      setState(() {
        avatar = tempImage;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 105, ratioY: 106));
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/register_bg.jpg"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 53),
              Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    'Đăng kí',
                    style: GoogleFonts.tomorrow(
                      fontSize: 48,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4)
                      ],
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.black,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    'Đăng kí',
                    style: GoogleFonts.tomorrow(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 13,
                  ),
                  Text(
                    'Hãy điền thông tin cần thiết',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4)
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 46),
              Column(
                children: [
                  RegisterTextField(
                    labelText: 'Email',
                    type: TextFieldType.email,
                    isDisabled: _isButtonDisabled,
                    border: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    controller: emailController,
                  ),
                  RegisterTextField(
                    labelText: 'Mật khẩu',
                    type: TextFieldType.password,
                    isDisabled: _isButtonDisabled,
                    controller: passwordController,
                    maxLength: 20,
                    // validator: (value) {
                    //   if (value != null) {
                    //     // if (value.isEmpty) {
                    //     //   return 'Vui lòng nhập mật khẩu';
                    //     // }
                    //     if (value.length < 6) {
                    //       this.eri
                    //       return '';
                    //     }
                    //   }
                    //   return null;
                    // }
                  ),
                  RegisterTextField(
                    labelText: 'Họ và tên',
                    type: TextFieldType.name,
                    isDisabled: _isButtonDisabled,
                    controller: nameController,
                    maxLength: 50,
                  ),
                  RegisterTextField(
                    labelText: 'CMND/CCCD',
                    border: const BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                    type: TextFieldType.number,
                    isDisabled: _isButtonDisabled,
                    maxLength: 12,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.2),
                          //     blurRadius: 4,
                          //     offset: const Offset(0, 4), // changes position of shadow
                          //   ),
                          // ],
                          borderRadius: BorderRadius.circular(12)),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          borderRadius: BorderRadius.circular(12),
                          value: dropdownValue,
                          iconSize: 0,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            suffixIcon: Image.asset(
                              'assets/dropdown.png',
                              width: 7.18,
                            ),
                            contentPadding: const EdgeInsets.only(
                                top: 14, bottom: 14, left: 18),
                            labelText: 'Giới tính',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                          items: genderList
                              .map<DropdownMenuItem<String>>(
                                  (value) => DropdownMenuItem(
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        value: value,
                                      ))
                              .toList(),
                          onChanged:
                              _isButtonDisabled ? null : dropdownCallback,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 19,
                  ),
                  Expanded(
                    child: RegisterTextField(
                      labelText: 'Ngày sinh',
                      type: TextFieldType.date,
                      isDisabled: _isButtonDisabled,
                      controller: dateController,
                      border: BorderRadius.circular(12),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              WidgetButton(
                labelText: 'Gửi mã OTP',
                onPressed: _isButtonDisabled
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Hệ thống đã gửi OTP')));
                      }
                    : () {
                        if (_formKey.currentState!.validate()) {
                          // Call api:
                          // Chưa có api
                          setState(() {
                            isValid = true;
                            _isButtonDisabled = true;
                          });
                          // String password = passwordController.text;
                          // var splittedName = nameController.text.split(' ');
                          // String name = splittedName.removeLast();
                          // String surname = splittedName.join('');
                          // String email = emailController.text;
                          // MDUser mdUser = MDUser(
                          //     name: name,
                          //     surname: surname,
                          //     email: email,
                          //     password: password);
                          //provider!.register(mdUser, context);
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: ((context) => ConfirmRegisterScreen(
                          //           mdUser: mdUser,
                          //         ))));
                        } else
                          setState(() {
                            isValid = false;
                          });
                      },
              ),
              if (isValid == true)
                Column(
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        'Đã gửi OTP, vui lòng check trong hộp thư của bạn và điền mã OTP vào ô dưới đây',
                        style:
                            TextStyle(color: Color(0xFF0038FF), fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.25),
                          //     blurRadius: 4,
                          //     offset: const Offset(0, 4),
                          //   ),
                          // ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Form(
                          key: _otpFormKey,
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6)
                              ],
                              validator: (value) {
                                if (value != null) {
                                  if (value.length < 6) {
                                    setState(() {
                                      validOTP = false;
                                    });
                                    return '';
                                  }
                                }
                                setState(() {
                                  validOTP = true;
                                });
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  contentPadding: EdgeInsets.all(26))),
                        )),
                    if (validOTP != null && validOTP == false)
                      Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'OTP không đúng',
                            style: GoogleFonts.inter(
                                color: const Color(0xFFFF0000), fontSize: 12),
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 53,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Checkbox(
                              activeColor: Colors.black,
                              value: checkBoxValue,
                              onChanged: ((value) {
                                setState(() {
                                  checkBoxValue = value;
                                });
                              })),
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
                                      text: 'điều khoản',
                                      style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.underline,
                                      )),
                                  TextSpan(text: ' của chúng tôi'),
                                ],
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 53),
                    WidgetButton(
                      labelText: 'Đăng kí',
                      onPressed: (() {
                        if (_otpFormKey.currentState!.validate()) {
                          // Call api:
                          // Chưa có api
                          setState(() {});
                          if (checkBoxValue == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Vui lòng chấp nhận điều khoản.')));
                          } else {}
                        }
                      }),
                    ),
                  ],
                ),
              const SizedBox(height: 53),
            ],
          ),
        ),
      ),
    )));
  }
}

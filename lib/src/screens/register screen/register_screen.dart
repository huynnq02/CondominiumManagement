import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/register_provider.dart';
import 'dart:io';
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
  String dropdownValue = genderList.first;
  File? avatar;

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
    }
    on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path, aspectRatio: const CropAspectRatio(ratioX: 105, ratioY: 106));
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: AppColors.White,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
                      Column(
                        children: [
                          const SizedBox(height: 2),
                          Image.asset('assets/register_avatar.png'),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => pickImage(),
                        child: Container(
                          width: 105,
                          height: 106,
                          color: Colors.white,
                          child: avatar != null ? Image.file(avatar!) : const Center(
                            child: Text('Bấm để chọn ảnh đại diện',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              color: Color(0xff636363)
                            ),)
                          ),
                        ),
                      )
                      ]),
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

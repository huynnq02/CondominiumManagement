import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/apartment_provider.dart';
import 'package:untitled/src/providers/otp_provider.dart';
import 'package:intl/intl.dart';
import 'package:untitled/src/widget/custom_boxshadow.dart';
import 'package:untitled/src/widget/outlined_text.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import '../../widget/register_textfield.dart';

const List<String> genderList = <String>['Nam', 'Nữ'];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  OTPProvider? otpProvider;
  ApartmentProvider? apartmentProvider;
  String? password;
  String dropdownValue = genderList.first;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController buildingIdController = TextEditingController();
  final TextEditingController apartmentIdController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final ScrollController _controller = ScrollController();
  bool? checkBoxValue = false;
  bool? showError = false;
  bool? validOTP;
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  String? otp;
  MDUser? mdUser;
  String confirmErr = '';

  @override
  void initState() {
    super.initState();
    otpProvider = Provider.of<OTPProvider>(context, listen: false);
    apartmentProvider = Provider.of<ApartmentProvider>(context, listen: false);
    apartmentProvider!.getAllApartments();
  }

  @override
  void dispose() {
    otpProvider!.reset();
    super.dispose();
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue = selectedValue;
      });
    }
  }

  String getDateString(DateTime date) => DateFormat('d/M/yyyy').format(date);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = getDateString(selectedDate);
      });
    }
  }

  Future<void> sendOTP(data) async {
    setState(() {});
    if (_formKey.currentState!.validate()) {
      setState(() {
        data.emailError= '';
      });
      if (passwordController.text == confirmPasswordController.text) {
        setState(() {
          confirmErr = '';
        });
        if (checkBoxValue == true) {
          mdUser = MDUser(
              name: nameController.text,
              surname: nameController.text,
              email: emailController.text,
              gender: dropdownValue,
              idNumber: idController.text,
              password: passwordController.text,
              birthDate: selectedDate.toIso8601String(),
              fullName: nameController.text,
              buildingId: buildingIdController.text,
              apartmentId: apartmentIdController.text);
          inspect(mdUser);

          //Hiển thị trạng thái loading
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
          await otpProvider!.sendOTP(mdUser!, context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Vui lòng chấp nhận điều khoản.')));
        }
      } else {
        setState(() {
          confirmErr = 'Mật khẩu không khớp';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OTPProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final apartmentData = Provider.of<ApartmentProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            color: AppColors.White,
            child: Stack(children: [
              Positioned(top: 28, right: -147, child: circlePattern()),
              Positioned(
                  bottom: height * 0.16, left: -128, child: circlePattern()),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 39, vertical: 23),
                decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //     image: AssetImage("assets/register_bg.jpg"),
                    //     fit: BoxFit.cover,
                    //     alignment: Alignment.topCenter),
                    ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedText(
                          text: 'Đăng ký',
                          fontSize: 48,
                          style: GoogleFonts.tomorrow(),
                          color: Colors.black,
                          strokeColor: Colors.white,
                          isShadowed: true,
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Text(
                          'Hãy điền thông tin cần thiết',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4)
                            ],
                          ),
                        ),
                        const SizedBox(height: 23),
                        Column(
                          children: [
                            ClipPath(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 2.5, right: 2.5, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    CustomBoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                        blurStyle: BlurStyle.outer)
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    RegisterTextField(
                                      labelText: 'Email/ Số điện thoại',
                                      type: TextFieldType.email,
                                      border: const BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                      error: data.emailError,
                                      borderColor: false,
                                      controller: emailController,
                                    ),
                                    RegisterTextField(
                                      labelText: 'Mật khẩu',
                                      type: TextFieldType.password,
                                      controller: passwordController,
                                      maxLength: 20,
                                    ),
                                    RegisterTextField(
                                      labelText: 'Nhập lại mật khẩu',
                                      type: TextFieldType.password,
                                      controller: confirmPasswordController,
                                      maxLength: 20,
                                      error: confirmErr,
                                    ),
                                    RegisterTextField(
                                      labelText: 'Họ và tên',
                                      type: TextFieldType.name,
                                      controller: nameController,
                                      maxLength: 50,
                                    ),
                                    RegisterTextField(
                                      labelText: 'CMND / CCCD',
                                      controller: idController,
                                      type: TextFieldType.number,
                                      maxLength: 12,
                                    ),
                                    RegisterTextField(
                                      labelText: 'Tòa',
                                      controller: buildingIdController,
                                      type: TextFieldType.autocomplete,
                                      onSuggestionSelected: (suggestion) {
                                        if (suggestion !=
                                            buildingIdController.text) {
                                          setState(() {
                                            buildingIdController.text =
                                                suggestion;
                                            apartmentIdController.clear();
                                          });
                                        }
                                      },
                                      items: apartmentData.apartmentList
                                          .map((e) => e.buildingId)
                                          .toSet()
                                          .toList(),
                                      maxLength: 15,
                                    ),
                                    RegisterTextField(
                                      labelText: 'Mã căn hộ',
                                      controller: apartmentIdController,
                                      type: TextFieldType.autocomplete,
                                      items: apartmentData.apartmentList
                                          .where((element) =>
                                              element.apartmentId.contains(
                                                  buildingIdController.text))
                                          .map((e) => e.apartmentId)
                                          .toList(),
                                      border: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12.0),
                                        bottomRight: Radius.circular(12.0),
                                      ),
                                      onSuggestionSelected: (suggestion) {
                                        apartmentIdController.text = suggestion;
                                      },
                                      maxLength: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
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
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      value: value,
                                                    ))
                                            .toList(),
                                        onChanged: dropdownCallback,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 19,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: RegisterTextField(
                                      labelText: 'Ngày sinh',
                                      onTap: (context) => _selectDate(context),
                                      type: TextFieldType.date,
                                      controller: dateController,
                                      border: BorderRadius.circular(12),
                                      borderColor: false,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 28,
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
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                      TextSpan(text: ' của chúng tôi'),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Center(
                          child: SizedBox(
                            width: 185,
                            height: 48,
                            child: OutlinedButton(
                              child: OutlinedText(
                                text: 'Đăng ký',
                                style: GoogleFonts.lexendExa(),
                                fontSize: 16,
                                strokeColor: Colors.white.withOpacity(0.5),
                              ),
                              style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  side: const BorderSide(
                                      width: 1, color: Colors.white),
                                  backgroundColor: AppColors.DarkBlue,
                                  elevation: 4),
                              onPressed: () => sendOTP(data),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  Container circlePattern() {
    return Container(
      width: 246,
      height: 246,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300), color: AppColors.DarkBlue),
    );
  }
}

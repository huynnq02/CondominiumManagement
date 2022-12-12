import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/otp_provider.dart';
import 'package:untitled/src/providers/register_provider.dart';
import 'package:intl/intl.dart';
import '../../widget/register_textfield.dart';
import 'widget/widget_button.dart';

const List<String> genderList = <String>['Nam', 'Nữ'];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  OTPProvider? otpProvider;
  RegisterProvider? provider;
  String? password;
  String dropdownValue = genderList.first;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController apartmentIdController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final ScrollController _controller = ScrollController();
  bool? checkBoxValue = false;
  bool? showError = false;
  bool? isValid = false;
  bool? validOTP;
  bool _isButtonDisabled = false;
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  String? otp;
  MDUser? mdUser;

  @override
  void initState() {
    super.initState();
    otpProvider = Provider.of<OTPProvider>(context, listen: false);
    provider = Provider.of<RegisterProvider>(context, listen: false);
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
    if (_isButtonDisabled) return;
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

  Future<void> sendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isValid = true;
        _isButtonDisabled = true;
        scrollToOTP();
      });
      String fullName = nameController.text;
      String email = emailController.text + '@gmail.com';
      String gender = dropdownValue;
      String idNumber = idController.text;
      String password = passwordController.text;
      String birthDate = selectedDate.toIso8601String();
      String apartmentId = apartmentIdController.text;
      mdUser = MDUser(
        name: fullName,
        surname: fullName,
        email: email,
        gender: gender,
        idNumber: idNumber,
        password: password,
        birthDate: birthDate,
        fullName: fullName,
        apartmentId: apartmentId
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hãy kiểm tra hộp thư của bạn.')));
      await otpProvider!.sendOTP(mdUser!, context);
    } else {
      setState(() {
        isValid = false;
      });
    }
  }

  void scrollToOTP() {
    _controller.animateTo(
      300,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
        decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage("assets/register_bg.jpg"),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 53),
            Stack(
              children: <Widget>[
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
                  controller: idController,
                  type: TextFieldType.number,
                  isDisabled: _isButtonDisabled,
                  maxLength: 12,
                ),
                RegisterTextField(
                  labelText: 'Mã căn hộ',
                  controller: apartmentIdController,
                  border: const BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                  isDisabled: _isButtonDisabled,
                  maxLength: 15,
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
                            .map<DropdownMenuItem<String>>((value) =>
                                DropdownMenuItem(
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
                    onTap: (context) => _selectDate(context),
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
                  : (() => sendOTP()),
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
                            onChanged: (value) => otp = value,
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
                        setState(() {});
                        if (checkBoxValue == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Vui lòng chấp nhận điều khoản.')));
                        } else {
                          //Hiển thị trạng thái loading
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          provider!.register(mdUser!, otp!, context);
                        }
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
      ),
      if (isLoading)
        Align(
          alignment: FractionalOffset.center,
          child: Container(
          color: Colors.black,
          width: 70.0,
          height: 70.0,
          child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Center(child: CircularProgressIndicator()))),
        )
      else
        const SizedBox(),
    ]));
  }
}

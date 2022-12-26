import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/apartment_provider.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_button.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_textfield.dart';
import 'package:untitled/src/screens/register%20screen/register_confirm_screen.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:intl/intl.dart';
import '../../models/user.dart';
import '../../providers/otp_provider.dart';

const List<String> genderList = <String>['Nam', 'Nữ'];

class RegisterInfoScreen extends StatefulWidget {
  final String email;
  final String password;
  final bool isEmail;
  const RegisterInfoScreen(
      {Key? key,
      required this.email,
      required this.password,
      required this.isEmail})
      : super(key: key);

  @override
  State<RegisterInfoScreen> createState() => _RegisterInfoScreenState();
}

class _RegisterInfoScreenState extends State<RegisterInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  OTPProvider? otpProvider;
  ApartmentProvider? apartmentProvider;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController buildingIdController = TextEditingController();
  final TextEditingController apartmentIdController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  String dropdownValue = genderList.first;
  DateTime selectedDate = DateTime.now();
  MDUser? mdUser;

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
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: AppColors.DarkPink),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = getDateString(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final apartmentData = Provider.of<ApartmentProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.White,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 39, vertical: height * 0.06),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.06,
                      ),
                      const Text(
                        'Nhập thông tin cá nhân. Chúng tôi sẽ dùng để xác thực tài khoản của bạn.',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        controller: nameController,
                        labelText: 'Họ và tên',
                        type: TextFieldType.name,
                        maxLength: 50,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2))),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Colors.white,
                                ),
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButtonFormField(
                                    borderRadius: BorderRadius.circular(12),
                                    value: dropdownValue,
                                    iconSize: 0,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: Image.asset(
                                        'assets/dropdown.png',
                                        width: 7.18,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          top: 14,
                                          bottom: 12,
                                          left: 6,
                                          right: 6),
                                      label: const Padding(
                                        padding: EdgeInsets.only(left: 22),
                                        child: Text('Giới tính',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black)),
                                      ),
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
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
                          ),
                          SizedBox(
                            width: width * 0.044,
                          ),
                          Expanded(
                            flex: 5,
                            child: CustomTextField(
                              labelText: 'Ngày sinh',
                              onTap: (context) => _selectDate(context),
                              type: TextFieldType.date,
                              controller: dateController,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomTextField(
                        controller: idController,
                        labelText: 'CMND / CCCD',
                        type: TextFieldType.number,
                        maxLength: 12,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: CustomTextField(
                              controller: buildingIdController,
                              labelText: 'Tòa',
                              type: TextFieldType.autocomplete,
                              onSuggestionSelected: (suggestion) {
                                if (suggestion != buildingIdController.text) {
                                  setState(() {
                                    buildingIdController.text = suggestion;
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
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Expanded(
                            flex: 6,
                            child: CustomTextField(
                              labelText: 'Mã căn hộ',
                              controller: apartmentIdController,
                              type: TextFieldType.autocomplete,
                              items: apartmentData.apartmentList
                                  .where((element) => element.apartmentId
                                      .contains(buildingIdController.text))
                                  .map((e) => e.apartmentId)
                                  .toList(),
                              onSuggestionSelected: (suggestion) {
                                apartmentIdController.text = suggestion;
                              },
                              maxLength: 15,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.077,
                      ),
                      CustomButton(
                          onPressed: () {
                            setState(() {});
                            if (_formKey.currentState!.validate()) {
                              mdUser = MDUser(
                                  name: nameController.text,
                                  surname: nameController.text,
                                  email: widget.isEmail ? widget.email : '',
                                  phoneNumber: widget.isEmail ? '' : widget.email,
                                  gender: dropdownValue,
                                  idNumber: idController.text,
                                  password: widget.password,
                                  birthDate: selectedDate.toIso8601String(),
                                  fullName: nameController.text,
                                  buildingId: buildingIdController.text,
                                  apartmentId: apartmentIdController.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterConfirmScreen(
                                  mdUser: mdUser!,
                                  isEmail: widget.isEmail,
                                ),
                              ));
                            }
                          },
                          label: 'Xác nhận')
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
                icon: SvgPicture.asset(
                  'assets/back.svg',
                  color: const Color(0xFF979A9C),
                ))
          ],
        ),
      ),
    );
  }
}

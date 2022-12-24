import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/apartment_provider.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_button.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_textfield.dart';
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
        data.emailError = '';
      });
      if (widget.isEmail) {
        mdUser = MDUser(
            name: nameController.text,
            surname: nameController.text,
            email: widget.email,
            gender: dropdownValue,
            idNumber: idController.text,
            password: widget.password,
            birthDate: selectedDate.toIso8601String(),
            fullName: nameController.text,
            buildingId: buildingIdController.text,
            apartmentId: apartmentIdController.text);

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
        mdUser = MDUser(
            name: nameController.text,
            surname: nameController.text,
            email: '',
            phoneNumber: widget.email,
            gender: dropdownValue,
            idNumber: idController.text,
            password: widget.password,
            birthDate: selectedDate.toIso8601String(),
            fullName: nameController.text,
            buildingId: buildingIdController.text,
            apartmentId: apartmentIdController.text);
        otpProvider!.sendSMSOTP(context,mdUser!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OTPProvider>(context);
    final apartmentData = Provider.of<ApartmentProvider>(context);
    final width = MediaQuery.of(context).size.width;
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
                    controller: nameController,
                    labelText: 'Họ và tên',
                    type: TextFieldType.name,
                    maxLength: 50,
                  ),
                  const SizedBox(
                    height: 29,
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
                                    top: 14, bottom: 12, left: 6, right: 6),
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
                                  .map<DropdownMenuItem<String>>((value) =>
                                      DropdownMenuItem(
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: dropdownCallback,
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
                  const SizedBox(
                    height: 29,
                  ),
                  CustomTextField(
                    controller: idController,
                    labelText: 'CMND / CCCD',
                    type: TextFieldType.number,
                    maxLength: 12,
                  ),
                  const SizedBox(
                    height: 29,
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
                  const SizedBox(
                    height: 29,
                  ),
                  CustomButton(
                      onPressed: () => sendOTP(data), label: 'Xác nhận')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

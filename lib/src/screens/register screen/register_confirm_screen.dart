import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_button.dart';
import 'package:untitled/src/screens/register%20screen/widget/info_field.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import '../../models/user.dart';
import '../../providers/register_provider.dart';

class RegisterConfirmScreen extends StatefulWidget {
  final MDUser mdUser;
  final bool isEmail;
  const RegisterConfirmScreen({
    Key? key,
    required this.mdUser,
    required this.isEmail,
  }) : super(key: key);

  @override
  State<RegisterConfirmScreen> createState() => _RegisterConfirmScreenState();
}

class _RegisterConfirmScreenState extends State<RegisterConfirmScreen> {
  RegisterProvider? provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RegisterProvider>(context, listen: false);
  }

  String getFormattedDate(birthDate) {
    var date = DateTime.parse(birthDate);
    final DateFormat formatter = DateFormat('d/M/yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.White,
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 38, vertical: height * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      'Hãy kiểm tra lại thông tin trước khi gửi BQL xét duyệt.',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black)),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Thông tin đã gửi không thể thay đổi!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFFD0255E)),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: const Color(0xFF979A9C),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoField(
                            title: 'Họ và tên',
                            value: widget.mdUser.name,
                          ),
                          InfoField(
                            title: 'Email / Số điện thoại',
                            value: widget.isEmail
                                ? widget.mdUser.email
                                : widget.mdUser.phoneNumber!,
                          ),
                          InfoField(
                            title: 'Giới tính',
                            value: widget.mdUser.gender,
                          ),
                          InfoField(
                            title: 'Ngày sinh',
                            value: getFormattedDate(widget.mdUser.birthDate),
                          ),
                          InfoField(
                            title: 'CMND / CCCD',
                            value: widget.mdUser.idNumber,
                          ),
                          InfoField(
                            title: 'Toà',
                            value: widget.mdUser.buildingId!,
                          ),
                          InfoField(
                            title: 'Mã căn hộ',
                            value: widget.mdUser.apartmentId!,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      label: 'Quay về'),
                  SizedBox(
                    height: height * 0.0354,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.DarkPink,
                                ),
                              );
                            });
                        if (widget.isEmail) {
                          provider!.registerWithEmail(widget.mdUser, context);
                        } else {
                          provider!.registerWithPhone(widget.mdUser, context);
                        }
                      },
                      child: const Text('Xác nhận',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.DarkPink,
                              decoration: TextDecoration.underline)),
                    ),
                  )
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
      )),
    );
  }
}

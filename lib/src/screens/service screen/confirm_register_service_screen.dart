import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:provider/provider.dart';
import 'package:untitled/repository/service/serviceAPI_provider.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/providers/user_service_provider.dart';
import 'package:untitled/src/screens/service%20screen/widgets/register_dialog.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:intl/intl.dart';
import 'package:untitled/utils/helper/show_snack_bar.dart';

class ConfirmRegisterServiceScreen extends StatefulWidget {
  final ApartmentService service;

  const ConfirmRegisterServiceScreen({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  State<ConfirmRegisterServiceScreen> createState() =>
      _ConfirmRegisterServiceScreenState();
}

class _ConfirmRegisterServiceScreenState
    extends State<ConfirmRegisterServiceScreen> {
  final TextEditingController noteController = TextEditingController();
  DateTime createdAt = DateTime.now();
  late String maHD;
  bool isLoading = false;
  bool isRegister = false;
  int? cycle;
  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('Loai hinh dich vu: ${widget.service.typeService}');
    print('id dich vu: ${widget.service.id}');

    getData();
  }

  registerService() async {
    List<UserService> userServices =
        context.read<UserServiceProvider>().services;

    // for (var service in userServices) {
    //   if (service.serviceID == widget.service.id.toString()) {
    //     Navigator.pop(context, true);
    //     showSnackBar(context, 'Bạn đã đăng kí dịch vụ này rồi');
    //     return;
    //   }
    // }

    bool isExist = await ServicePro().checkExistService(widget.service.id);

    if (isExist) {
      Navigator.pop(context, true);
      showSnackBar(context, 'Bạn đã đăng kí dịch vụ này rồi');
      return;
    }

    final userProvider = context.read<ProfileProvider>();
    setState(() {
      isRegister = true;
    });
    print(cycle);
    UserService userService = UserService(
      billID: maHD,
      billName: widget.service.serviceName,
      serviceID: '${widget.service.id}',
      serviceName: widget.service.serviceName,
      ownerName: userProvider.mdUser.surname + ' ' + userProvider.mdUser.name,
      phoneNumber: userProvider.mdUser.phoneNumber.toString(),
      emailAddress: userProvider.mdUser.email,
      cycle: widget.service.cycle,
      price: widget.service.serviceCharge,
      note: noteController.text,
      state: '',
      startDate: createdAt.toIso8601String(),
      endDate: createdAt.add(Duration(days: cycle!)).toIso8601String(),
      typeService: widget.service.typeService,
      id: 0,
    );
    await ServicePro().registerServiceV2(userService);
    int id = await ServicePro().registerService(userService);
    userService = userService.setId(id);
    print('user service: ${userService}');
    context.read<UserServiceProvider>().addService(userService);
    Navigator.pop(context, true);
    showSnackBar(context, 'Đăng kí dịch vụ thành công');

    setState(() {
      isRegister = false;
    });
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    int res = await ServicePro().getNumBill() + 1;
    String tmp = res.toString();

    while (tmp.length != 3) {
      tmp = '0' + tmp;
    }
    cycle = int.parse(widget.service.cycle);
    DateTime createdAt = DateTime.now();

    maHD = 'HD${DateFormat('ddMM').format(createdAt)}$tmp';
    print('Ma hoa don: $maHD');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = context.read<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB2F68),
        elevation: 0,
        title: Text(
          'Xác nhận đăng ký',
          style: AppTextStyle.lato.copyWith(
            color: AppColors.White,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFCF6F6),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFDB2F68)),
            )
          : SizedBox(
              width: double.infinity,
              child: ListView(
                children: [
                  _buildBox(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStat(
                          'Tên người sử dụng',
                          userProvider.mdUser.surname +
                              ' ' +
                              userProvider.mdUser.name,
                        ),
                        _buildDivider(),
                        _buildStat(
                          'Số điện thoại',
                          userProvider.mdUser.phoneNumber.toString(),
                        ),
                      ],
                    ),
                  ),
                  _buildBox(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStat(
                          'Mã hoá đơn',
                          maHD,
                        ),
                        _buildDivider(),
                        _buildStat(
                          'Mã dịch vụ',
                          widget.service.id.toString(),
                        ),
                        _buildDivider(),
                        _buildStat(
                          'Tên dịch vụ',
                          widget.service.serviceName,
                        ),
                        _buildDivider(),
                        _buildStat(
                          'Ngày bắt đầu',
                          DateFormat("dd/MM/yyyy").format(createdAt),
                        ),
                        _buildDivider(),
                        _buildStat(
                          'Ngày kết thúc',
                          DateFormat("dd/MM/yyyy")
                              .format(createdAt.add(Duration(days: cycle!))),
                        ),
                        _buildDivider(),
                        _buildStat(
                          'Chu kì',
                          widget.service.cycle + ' ngày',
                        ),
                        _buildDivider(),
                        _buildStat(
                          'Hạn đóng',
                          DateFormat("dd/MM/yyyy")
                              .format(createdAt.add(Duration(days: cycle!))),
                          color: const Color(0xFFFF0000),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  isRegister
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFDB2F68),
                          ),
                        )
                      : GestureDetector(
                          onTap: registerService,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFDB2F68),
                            ),
                            child: Center(
                              child: Text(
                                'Xác nhận',
                                style: AppTextStyle.lato.copyWith(
                                  color: AppColors.White,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
      bottomNavigationBar: isLoading
          ? null
          : BottomAppBar(
              color: const Color(0xFFDB2F68),
              shape: const CircularNotchedRectangle(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Số tiền thanh toán',
                      style: AppTextStyle.lato.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      widget.service.serviceCharge.toVND(),
                      style: AppTextStyle.lato.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(color: Colors.black38),
    );
  }

  Widget _buildStat(String title, String content,
      {Color color = Colors.black}) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.lato.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          content,
          style: AppTextStyle.lato.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildBox(Widget child) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFD9D9D9),
        ),
      ),
      child: child,
    );
  }
}

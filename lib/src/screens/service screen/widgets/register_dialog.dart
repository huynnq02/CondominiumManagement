import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/repository/service/serviceAPI_provider.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/providers/user_service_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class RegisterDialog extends StatefulWidget {
  final ApartmentService apartmentService;
  const RegisterDialog({
    Key? key,
    required this.apartmentService,
  }) : super(key: key);

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final TextEditingController noteController = TextEditingController();
  DateTime createdAt = DateTime.now();
  late String maHD;
  bool isLoading = false;
  bool isRegister = false;

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('Loai hinh dich vu: ${widget.apartmentService.typeService}');

    getData();
  }

  registerService() async {
    List<UserService> userServices =
        context.read<UserServiceProvider>().services;

    for (var service in userServices) {
      if (service.serviceID == widget.apartmentService.id.toString()) {
        Navigator.pop(context, true);
        return;
      }
    }

    print('Ma hoa don: $maHD');
    final userProvider = context.read<ProfileProvider>();
    setState(() {
      isRegister = true;
    });
    int cycle = int.parse(widget.apartmentService.cycle);
    print(cycle);
    UserService userService = UserService(
      billID: maHD,
      billName: widget.apartmentService.serviceName,
      serviceID: '${widget.apartmentService.id}',
      serviceName: widget.apartmentService.serviceName,
      ownerName: userProvider.mdUser.surname + ' ' + userProvider.mdUser.name,
      phoneNumber: userProvider.mdUser.phoneNumber.toString(),
      emailAddress: userProvider.mdUser.email,
      cycle: widget.apartmentService.cycle,
      price: widget.apartmentService.serviceCharge,
      note: noteController.text,
      state: '',
      startDate: createdAt.toIso8601String(),
      endDate: createdAt.add(Duration(days: cycle)).toIso8601String(),
      typeService: widget.apartmentService.typeService,
      id: 0,
    );
    await ServicePro().registerServiceV2(userService);
    int id = await ServicePro().registerService(userService);
    userService = userService.setId(id);
    print('user service: ${userService}');
    context.read<UserServiceProvider>().addService(userService);
    Navigator.pop(context, true);
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

    DateTime createdAt = DateTime.now();

    maHD = 'HD${DateFormat('ddMM').format(createdAt)}$tmp';
    print('Ma hoa don: $maHD');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<ProfileProvider>();
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: isLoading
          ? SizedBox(
              width: size.width * .9,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: size.width * .9,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Spacer(flex: 3),
                      Text(
                        'Xác nhận đăng ký',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(flex: 2),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Mã hoá đơn',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        maHD,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(),
                  Row(
                    children: [
                      Text(
                        'Tên hoá đơn',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.apartmentService.serviceName,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Mã dịch vụ:  ',
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.apartmentService.id.toString(),
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 13,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Tên dịch vụ:  ',
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.apartmentService.serviceName,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 13,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _buildDivider(),
                  Row(
                    children: [
                      Text(
                        'Tên người sử dụng',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        userProvider.mdUser.surname +
                            ' ' +
                            userProvider.mdUser.name,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(),
                  Row(
                    children: [
                      Text(
                        'Số điện thoại',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        userProvider.mdUser.phoneNumber!,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(),
                  Row(
                    children: [
                      Text(
                        'Chu kì',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.apartmentService.cycle + ' ngày',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(),
                  Row(
                    children: [
                      Text(
                        'Ngày bắt đầu',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat("dd/MM/yyyy").format(createdAt),
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(),
                  Row(
                    children: [
                      Text(
                        'Ngày kết thúc',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat("dd/MM/yyyy")
                            .format(createdAt.add(const Duration(days: 30))),
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(),
                  Row(
                    children: [
                      Text(
                        'Số tiền thanh toán',
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.apartmentService.serviceCharge.toVND(),
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Thêm ghi chú',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  isRegister
                      ? const CircularProgressIndicator(
                          color: Color(0xFF1D6D54))
                      : GestureDetector(
                          onTap: registerService,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFF1D6D54),
                            ),
                            child: Center(
                              child: Text(
                                'Xác nhận',
                                style: AppTextStyle.lato.copyWith(
                                  color: AppColors.White,
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(color: Colors.black),
    );
  }
}

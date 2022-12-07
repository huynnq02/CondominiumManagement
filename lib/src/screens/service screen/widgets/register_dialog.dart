import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/providers/profile_provider.dart';
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

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {}

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<ProfileProvider>();
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: size.width * .9,
        padding: const EdgeInsets.all(10),
        child: Column(
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
                  'Mã hoá đơn',
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
                  'Mã hoá đơn',
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
                  userProvider.mdUser.surname + ' ' + userProvider.mdUser.name,
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
                  widget.apartmentService.cycle,
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
            GestureDetector(
              onTap: () async {},
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

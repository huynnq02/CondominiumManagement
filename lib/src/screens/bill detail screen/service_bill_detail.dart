import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';

import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import 'package:untitled/src/screens/bill%20detail%20screen/widgets/service_bill_container.dart';

class ServiceBillDetailScreen extends StatelessWidget {
  final ServiceBill serviceBill;
  const ServiceBillDetailScreen({Key? key, required this.serviceBill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết hóa đơn",
          style: TextStyle(
            color: AppColors.White,
          ),
        ),
        backgroundColor: const Color(0xFF1D6D54),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.White,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: height * 0.03,
            left: width * 0.05,
            right: width * 0.05,
            bottom: height * 0.02),
        child: Column(
          children: [
            if (serviceBill.state == "Chưa thanh toán")
              Padding(
                padding: EdgeInsets.only(
                  bottom: height * 0.02,
                ),
                child: Text(
                  "Quý khách đến văn phòng ban quản lý vui lòng xuất trình chi tiết hóa đơn trước khi thanh toán",
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ServiceBillDetailContainer(
                serviceBill: serviceBill)
          ],
        ),
      ),
    );
  }
}

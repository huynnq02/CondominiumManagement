import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/divider.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/row_data.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/service_bill_detail_container.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';
import 'package:untitled/src/screens/bill detail screen/widgets/custom_rich_text.dart';

class ServiceBillOfficePaymentScreen extends StatelessWidget {
  final ServiceBill serviceBill;
  const ServiceBillOfficePaymentScreen({Key? key, required this.serviceBill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFCF6F6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFDB2F68),
        title: const Text(
          "Thanh toán hóa đơn",
          style: TextStyle(
            color: AppColors.White,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
              ..pop()
              ..pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.White,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              if (serviceBill.state == "Chưa thanh toán")
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.02,
                    left: width * 0.07,
                    right: width * 0.07,
                  ),
                  child: Text(
                    "Quý khách đến văn phòng ban quản lý vui lòng xuất trình chi tiết hóa đơn trước khi thanh toán",
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ServiceBillDetailContainer(serviceBill: serviceBill)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(
              0xFFDB2F68,
            ),
          ),
          padding: EdgeInsets.only(
              top: height * 0.02,
              left: width * 0.05,
              right: width * 0.05,
              bottom: height * 0.02),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Số tiền thanh toán",
                  style: AppTextStyle.lato.copyWith(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                Text(
                  serviceBill.price.toString().formatMoney(),
                  style: AppTextStyle.lato.copyWith(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

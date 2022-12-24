import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/divider.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/row_data.dart';
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
      appBar: AppBar(
        title: const Text(
          "Thanh toán hóa đơn",
          style: TextStyle(
            color: AppColors.White,
          ),
        ),
        backgroundColor: const Color(0xFF1D6D54),
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: serviceBill.state == "Chưa thanh toán"
                      ? AppColors.Black
                      : serviceBill.state == "Đã thanh toán"
                          ? const Color(0xFF2AC956)
                          : const Color(0xFF5C92FE),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: height * 0.05,
                  left: width * 0.03,
                  right: width * 0.03,
                  bottom: height * 0.03,
                ),
                child: Column(
                  children: [
                    RowDetail(title: "Mã hóa đơn:", data: serviceBill.billID!),
                    divider(height: height),
                    RowDetail(
                        title: "Tên hóa đơn:", data: serviceBill.billName),
                    divider(height: height),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRichText(
                            "Mã dịch vụ: ",
                            serviceBill.serviceId == null
                                ? "AN01"
                                : serviceBill.serviceId!,
                            14,
                          ),
                          const VerticalDivider(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            thickness: 1,
                          ),
                          CustomRichText(
                            "Tên dịch vụ: ",
                            serviceBill.serviceName,
                            14,
                          ),
                        ],
                      ),
                    ),
                    divider(height: height),
                    RowDetail(
                        title: "Tên người sử dụng:",
                        data: serviceBill.ownerName),
                    divider(height: height),
                    RowDetail(
                      title: "Số điện thoại:",
                      data: serviceBill.phoneNumber == null
                          ? "0123456789"
                          : serviceBill.phoneNumber!,
                    ),
                    divider(height: height),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          CustomRichText(
                            "Chu kì: ",
                            serviceBill.cycle == null
                                ? "1 tháng"
                                : serviceBill.cycle!.toString() + " tháng",
                            10,
                          ),
                          const VerticalDivider(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            thickness: 1,
                          ),
                          CustomRichText(
                            "Ngày bắt đầu: ",
                            serviceBill.startDay.formatDateTime(),
                            10,
                          ),
                          const VerticalDivider(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            thickness: 1,
                          ),
                          CustomRichText(
                            "Ngày kết thúc: ",
                            serviceBill.endDay.formatDateTime(),
                            10,
                          ),
                        ],
                      ),
                    ),
                    divider(height: height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          "Hạn đóng: ",
                          serviceBill.paymentTerm.formatDateTime(),
                          14,
                        ),
                        const VerticalDivider(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          thickness: 1,
                        ),
                        CustomRichText(
                          "Số tiền thanh toán: ",
                          serviceBill.price.toString().formatMoney(),
                          14,
                        ),
                      ],
                    ),
                    if (serviceBill.state == "Chờ tiếp nhận")
                      Column(
                        children: [
                          SizedBox(
                            width: width * 0.4,
                            child: divider(
                              height: height,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Hóa đơn đã được ban quản lí tiếp nhận vào ngày ${serviceBill.paymentTerm.formatDateTime()}",
                              style: AppTextStyle.lato.copyWith(
                                fontSize: 14,
                                color: const Color(0xFF5C92FE),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    if (serviceBill.state == "Đã thanh toán")
                      Column(
                        children: [
                          SizedBox(
                            width: width * 0.4,
                            child: divider(
                              height: height,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Hóa đơn đã được thanh toán vào ngày ${serviceBill.paymentTerm.formatDateTime()}",
                              style: AppTextStyle.lato.copyWith(
                                  fontSize: 14, color: const Color(0xFF2AC956)),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

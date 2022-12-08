import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/custom_rich_text.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/divider.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/row_data.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class ServiceBillDetailContainer extends StatefulWidget {
  const ServiceBillDetailContainer({
    Key? key,
    required this.serviceBill,
  }) : super(key: key);

  final ServiceBill serviceBill;

  @override
  State<ServiceBillDetailContainer> createState() =>
      _ServiceBillDetailContainerState();
}

class _ServiceBillDetailContainerState
    extends State<ServiceBillDetailContainer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.serviceBill.state == "Chưa thanh toán"
              ? AppColors.Black
              : widget.serviceBill.state == "Đã thanh toán"
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
            RowDetail(title: "Mã hóa đơn:", data: widget.serviceBill.billID!),
            divider(height: height),
            RowDetail(title: "Tên hóa đơn:", data: widget.serviceBill.billName),
            divider(height: height),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRichText(
                    "Mã dịch vụ: ",
                    widget.serviceBill.serviceId == null
                        ? "AN01"
                        : widget.serviceBill.serviceId!,
                    14,
                  ),
                  const VerticalDivider(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    thickness: 1,
                  ),
                  CustomRichText(
                    "Tên dịch vụ: ",
                    widget.serviceBill.serviceName,
                    14,
                  ),
                ],
              ),
            ),
            divider(height: height),
            RowDetail(
                title: "Tên người sử dụng:",
                data: widget.serviceBill.ownerName),
            divider(height: height),
            RowDetail(
              title: "Số điện thoại:",
              data: widget.serviceBill.phoneNumber == null
                  ? "0123456789"
                  : widget.serviceBill.phoneNumber!,
            ),
            divider(height: height),
            IntrinsicHeight(
              child: Row(
                children: [
                  CustomRichText(
                    "Chu kì: ",
                    widget.serviceBill.cycle == null
                        ? "1 tháng"
                        : widget.serviceBill.cycle!.toString() + " tháng",
                    10,
                  ),
                  const VerticalDivider(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    thickness: 1,
                  ),
                  CustomRichText(
                    "Ngày bắt đầu: ",
                    widget.serviceBill.startDay.formatDateTime(),
                    10,
                  ),
                  const VerticalDivider(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    thickness: 1,
                  ),
                  CustomRichText(
                    "Ngày kết thúc: ",
                    widget.serviceBill.endDay.formatDateTime(),
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
                  widget.serviceBill.paymentTerm.formatDateTime(),
                  14,
                ),
                const VerticalDivider(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  thickness: 1,
                ),
                CustomRichText(
                  "Số tiền thanh toán: ",
                  widget.serviceBill.price.toString().formatMoney(),
                  14,
                ),
              ],
            ),
            if (widget.serviceBill.state == "Chờ tiếp nhận")
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
                      "Hóa đơn đã được ban quản lí tiếp nhận vào ngày ${widget.serviceBill.paymentTerm.formatDateTime()}",
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF5C92FE),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            if (widget.serviceBill.state == "Đã thanh toán")
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
                      "Hóa đơn đã được thanh toán vào ngày ${widget.serviceBill.paymentTerm.formatDateTime()}",
                      style: AppTextStyle.lato.copyWith(
                          fontSize: 14, color: const Color(0xFF2AC956)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

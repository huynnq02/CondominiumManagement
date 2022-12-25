import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/bill_row_info.dart';
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
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.02,
        left: width * 0.07,
        right: width * 0.07,
        bottom: height * 0.03,
      ),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Column(
            children: [
              BillRowInfo(
                name: "Tên người sử dụng",
                value: widget.serviceBill.ownerName,
                topRadius: 20,
                topBorder: 1,
                bottomBorder: 1,
              ),
              BillRowInfo(
                name: "Số điện thoại",
                value: widget.serviceBill.phoneNumber ?? "113",
                bottomRadius: 20,
                topBorder: 1,
                bottomBorder: 1,
              ),
            ],
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Column(
            children: [
              BillRowInfo(
                name: "Mã hóa đơn:",
                value: widget.serviceBill.billID!,
                topRadius: 20,
                topBorder: 1,
                bottomBorder: 1,
              ),
              BillRowInfo(
                name: "Tên hóa đơn:",
                value: widget.serviceBill.billName,
                topBorder: 1,
                bottomBorder: 1,
              ),
              BillRowInfo(
                name: "Mã dịch vụ:",
                value: widget.serviceBill.serviceId ?? "DV69699696",
                topBorder: 1,
                bottomBorder: 1,
              ),
              BillRowInfo(
                name: "Tên dịch vụ:",
                value: widget.serviceBill.serviceName,
                topBorder: 1,
                bottomBorder: 1,
              ),
              BillRowInfo(
                name: "Ngày bắt đầu:",
                value: widget.serviceBill.startDay.formatDateTime(),
                topBorder: 1,
                bottomBorder: 1,
              ),
              BillRowInfo(
                name: "Ngày kết thúc:",
                value: widget.serviceBill.startDay.formatDateTime(),
                topBorder: 1,
                bottomBorder: 1,
              ),
              BillRowInfo(
                name: "Chu kì:",
                value: widget.serviceBill.startDay.formatDateTime(),
                topBorder: 1,
                bottomBorder: 1,
              ),
              BillRowInfo(
                name: "Hạn đóng:",
                value: widget.serviceBill.startDay.formatDateTime(),
                topBorder: 1,
                bottomBorder: 1,
                bottomRadius: 20,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              if (widget.serviceBill.state == "Từ chối thanh toán")
                Column(
                  children: [
                    Center(
                      child: Text(
                        "Hóa đơn bị từ chối thanh toán vì",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 14,
                          color: const Color(0xFFFF0000),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        "..................",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 14,
                          color: const Color(0xFFFF0000),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              if (widget.serviceBill.state == "Chờ tiếp nhận")
                Column(
                  children: [
                    Center(
                      child: Text(
                        "Hóa đơn đã được ban quản lí tiếp nhận vào ngày ${widget.serviceBill.paymentTerm.formatDateTime()}",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 14,
                          color: const Color(0xFF5C92FE),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              if (widget.serviceBill.state == "Đã thanh toán")
                Column(
                  children: [
                    Center(
                      child: Text(
                        "Hóa đơn đã được thanh toán vào ngày ${widget.serviceBill.paymentTerm.formatDateTime()}",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 14,
                          color: const Color(0xFF2AC956),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/bill_row_info.dart';

import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class ApartmentBillDetailContainer extends StatefulWidget {
  const ApartmentBillDetailContainer({
    Key? key,
    required this.apartmentBill,
  }) : super(key: key);

  final ApartmentBill apartmentBill;

  @override
  State<ApartmentBillDetailContainer> createState() =>
      _ApartmentBillDetailContainerState();
}

class _ApartmentBillDetailContainerState
    extends State<ApartmentBillDetailContainer> {
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
          Column(
            children: [
              BillRowInfo(
                name: "Mã căn hộ",
                value: widget.apartmentBill.apartmentID,
                topRadius: 20,
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
                value: widget.apartmentBill.billID!,
                topRadius: 20,
                topBorder: 1,
                bottomBorder: 1,
              ),
              BillRowInfo(
                name: "Tên hóa đơn:",
                value: widget.apartmentBill.billName,
                topBorder: 1,
                bottomBorder: 1,
              ),
              if (widget.apartmentBill.billType == "Điện" ||
                  widget.apartmentBill.billType == "Nước")
                Column(
                  children: [
                    BillRowInfo(
                      name: "Ngày bắt đầu:",
                      value: widget.apartmentBill.startDay.formatDateTime(),
                      topBorder: 1,
                      bottomBorder: 1,
                    ),
                    BillRowInfo(
                      name: "Ngày kết thúc:",
                      value: widget.apartmentBill.startDay.formatDateTime(),
                      topBorder: 1,
                      bottomBorder: 1,
                    ),
                    BillRowInfo(
                      name: "Chỉ số cũ:",
                      value: widget.apartmentBill.oldIndex.toString(),
                      topBorder: 1,
                      bottomBorder: 1,
                    ),
                    BillRowInfo(
                      name: "Chỉ số mới:",
                      value: widget.apartmentBill.newIndex.toString(),
                      topBorder: 1,
                      bottomBorder: 1,
                    ),
                    BillRowInfo(
                      name: "Tổng tiêu thụ:",
                      value: (widget.apartmentBill.newIndex -
                              widget.apartmentBill.oldIndex)
                          .toString(),
                      topBorder: 1,
                      bottomBorder: 1,
                    ),
                    BillRowInfo(
                      name: "Đơn giá:",
                      value: widget.apartmentBill.billType == "Nước"
                          ? widget.apartmentBill.priceOfApartment
                                  .toString()
                                  .formatMoney() +
                              "   / m³"
                          : widget.apartmentBill.priceOfApartment
                                  .toString()
                                  .formatMoney() +
                              "   / kWh",
                      topBorder: 1,
                      bottomBorder: 1,
                    ),
                  ],
                ),
              if (widget.apartmentBill.billType == "Quản lí")
                Column(
                  children: [
                    BillRowInfo(
                      name: "Kì hóa đơn:",
                      value: widget.apartmentBill.invoicePeriod
                          .formatDateTimeMonthYear(),
                      topBorder: 1,
                      bottomBorder: 1,
                    ),
                    BillRowInfo(
                      name: "Diện tích:",
                      value: widget.apartmentBill.areaOfApartment.toString() +
                          " m²",
                      topBorder: 1,
                      bottomBorder: 1,
                    ),
                    BillRowInfo(
                      name: "Đơn giá:",
                      value: widget.apartmentBill.priceOfApartment
                              .toString()
                              .formatMoney() +
                          " / m²",
                      topBorder: 1,
                      bottomBorder: 1,
                    ),
                  ],
                ),
              if (widget.apartmentBill.billType == "Rác")
                BillRowInfo(
                  name: "Kì hóa đơn:",
                  value: widget.apartmentBill.invoicePeriod
                      .formatDateTimeMonthYear(),
                  topBorder: 1,
                  bottomBorder: 1,
                ),
              BillRowInfo(
                name: "Hạn đóng:",
                value: widget.apartmentBill.startDay.formatDateTime(),
                topBorder: 1,
                bottomBorder: 1,
                bottomRadius: 20,
                color: const Color(0xFFFF0000),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              if (widget.apartmentBill.state == "Từ chối thanh toán")
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
              if (widget.apartmentBill.state == "Chờ tiếp nhận")
                Column(
                  children: [
                    Center(
                      child: Text(
                        "Hóa đơn đã được ban quản lí tiếp nhận vào ngày ${widget.apartmentBill.paymentTerm.formatDateTime()}",
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
              if (widget.apartmentBill.state == "Đã thanh toán")
                Column(
                  children: [
                    Center(
                      child: Text(
                        "Hóa đơn đã được thanh toán vào ngày ${widget.apartmentBill.datePayment!.formatDateTime()}",
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

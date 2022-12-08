import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/custom_rich_text.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/divider.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/row_data.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.apartmentBill.state == "Chưa thanh toán"
              ? AppColors.Black
              : widget.apartmentBill.state == "Đã thanh toán"
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
            RowDetail(title: "Mã hóa đơn:", data: widget.apartmentBill.billID!),
            divider(height: height),
            RowDetail(
                title: "Tên hóa đơn:", data: widget.apartmentBill.billName),
            divider(height: height),
            RowDetail(
                title: "Mã căn hộ:", data: widget.apartmentBill.apartmentID),
            divider(height: height),
            const RowDetail(title: "Kỳ hóa đơn:", data: "09/2022"),
            divider(height: height),
            if (widget.apartmentBill.billType == 'Quản lí')
              Column(
                children: [
                  const RowDetail(title: "Diện tích: ", data: "50 m²"),
                  divider(height: height),
                ],
              ),
            if (widget.apartmentBill.billType == "Điện")
              Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          "Chỉ số cũ: ",
                          widget.apartmentBill.oldIndex.toString() + " kWh",
                          11,
                        ),
                        const VerticalDivider(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          thickness: 1,
                        ),
                        CustomRichText(
                          "Chỉ số mới: ",
                          widget.apartmentBill.newIndex.toString() + " kWh",
                          11,
                        ),
                        const VerticalDivider(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          thickness: 1,
                        ),
                        CustomRichText(
                          "Lượng tiêu thụ: ",
                          (widget.apartmentBill.newIndex -
                                      widget.apartmentBill.oldIndex)
                                  .toString() +
                              " kWh",
                          11,
                        ),
                      ],
                    ),
                  ),
                  divider(height: height),
                ],
              ),
            if (widget.apartmentBill.billType == "Nước")
              Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          "Chỉ số cũ: ",
                          widget.apartmentBill.oldIndex.toString() + " m³",
                          11,
                        ),
                        const VerticalDivider(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          thickness: 1,
                        ),
                        CustomRichText(
                          "Chỉ số mới: ",
                          widget.apartmentBill.newIndex.toString() + " m³",
                          11,
                        ),
                        const VerticalDivider(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          thickness: 1,
                        ),
                        CustomRichText(
                          "Lượng tiêu thụ: ",
                          (widget.apartmentBill.newIndex -
                                      widget.apartmentBill.oldIndex)
                                  .toString() +
                              " m³",
                          10,
                        ),
                      ],
                    ),
                  ),
                  divider(height: height),
                ],
              ),
            if (widget.apartmentBill.billType != "Quản lí")
              RowDetail(
                title: "Hạn đóng: ",
                data: widget.apartmentBill.paymentTerm.formatDateTime(),
              ),
            if (widget.apartmentBill.billType == "Quản lí")
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRichText(
                      "Hạn đóng: ",
                      widget.apartmentBill.paymentTerm.formatDateTime(),
                      11,
                    ),
                    const VerticalDivider(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      thickness: 1,
                    ),
                    CustomRichText(
                      "Đơn giá: ",
                      "10.000đ / m³",
                      11,
                    ),
                  ],
                ),
              ),
            divider(height: height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Số tiền thanh toán",
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.apartmentBill.price.toString().formatMoney(),
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.Red,
                  ),
                ),
              ],
            ),
            if (widget.apartmentBill.state == "Chờ tiếp nhận")
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
                      "Hóa đơn đã được ban quản lí tiếp nhận vào ngày ${widget.apartmentBill.paymentTerm.formatDateTime()}",
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF5C92FE),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            if (widget.apartmentBill.state == "Đã thanh toán")
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
                      "Hóa đơn đã được thanh toán vào ngày ${widget.apartmentBill.paymentTerm.formatDateTime()}",
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF2AC956),
                      ),
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

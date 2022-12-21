import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/divider.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/row_data.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';
import 'package:untitled/src/screens/bill detail screen/widgets/custom_rich_text.dart';

class ApartmentBillOfficePaymentScreen extends StatelessWidget {
  final ApartmentBill apartmentBill;
  const ApartmentBillOfficePaymentScreen(
      {Key? key, required this.apartmentBill})
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
            if (apartmentBill.state == "Chưa thanh toán")
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
                  color: apartmentBill.state == "Chưa thanh toán"
                      ? AppColors.Black
                      : apartmentBill.state == "Đã thanh toán"
                          ? const Color(0xFF2AC956)
                          : apartmentBill.state == "Từ chối thanh toán"
                              ? const Color(0xFFFFC000)
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
                    RowDetail(
                        title: "Mã hóa đơn:", data: apartmentBill.billID!),
                    divider(height: height),
                    RowDetail(
                        title: "Tên hóa đơn:", data: apartmentBill.billName),
                    divider(height: height),
                    RowDetail(
                        title: "Mã căn hộ:", data: apartmentBill.apartmentID),
                    divider(height: height),
                    const RowDetail(title: "Kỳ hóa đơn:", data: "09/2022"),
                    divider(height: height),
                    if (apartmentBill.billType == 'Quản lí')
                      Column(
                        children: [
                          const RowDetail(title: "Diện tích: ", data: "50 m²"),
                          divider(height: height),
                        ],
                      ),
                    if (apartmentBill.billType == "Điện")
                      Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomRichText(
                                  "Chỉ số cũ: ",
                                  apartmentBill.oldIndex.toString() + " kWh",
                                  11,
                                ),
                                const VerticalDivider(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  thickness: 1,
                                ),
                                CustomRichText(
                                  "Chỉ số mới: ",
                                  apartmentBill.newIndex.toString() + " kWh",
                                  11,
                                ),
                                const VerticalDivider(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  thickness: 1,
                                ),
                                CustomRichText(
                                  "Lượng tiêu thụ: ",
                                  (apartmentBill.newIndex -
                                              apartmentBill.oldIndex)
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
                    if (apartmentBill.billType == "Nước")
                      Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomRichText(
                                  "Chỉ số cũ: ",
                                  apartmentBill.oldIndex.toString() + " m³",
                                  11,
                                ),
                                const VerticalDivider(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  thickness: 1,
                                ),
                                CustomRichText(
                                  "Chỉ số mới: ",
                                  apartmentBill.newIndex.toString() + " m³",
                                  11,
                                ),
                                const VerticalDivider(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  thickness: 1,
                                ),
                                CustomRichText(
                                  "Lượng tiêu thụ: ",
                                  (apartmentBill.newIndex -
                                              apartmentBill.oldIndex)
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
                    if (apartmentBill.billType != "Quản lí")
                      RowDetail(
                        title: "Hạn đóng: ",
                        data: apartmentBill.paymentTerm.formatDateTime(),
                      ),
                    if (apartmentBill.billType == "Quản lí")
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomRichText(
                              "Hạn đóng: ",
                              apartmentBill.paymentTerm.formatDateTime(),
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
                          apartmentBill.price.toString().formatMoney(),
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Red,
                          ),
                        ),
                      ],
                    ),
                    if (apartmentBill.state == "Từ chối thanh toán")
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
                              "Hóa đơn bị từ chối thanh toán vì",
                              style: AppTextStyle.lato.copyWith(
                                fontSize: 14,
                                color: const Color(0xFFFFC000),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              "..................",
                              style: AppTextStyle.lato.copyWith(
                                fontSize: 14,
                                color: const Color(0xFFFFC000),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    if (apartmentBill.state == "Chờ tiếp nhận")
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
                              "Hóa đơn đã được ban quản lí tiếp nhận vào ngày ${apartmentBill.paymentTerm.formatDateTime()}",
                              style: AppTextStyle.lato.copyWith(
                                fontSize: 14,
                                color: const Color(0xFF5C92FE),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    if (apartmentBill.state == "Đã thanh toán")
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
                              "Hóa đơn đã được thanh toán vào ngày ${apartmentBill.paymentTerm.formatDateTime()}",
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
            ),
          ],
        ),
      ),
    );
  }
}

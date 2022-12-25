import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/apartment_bill_detail_container.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/service_bill_detail_container.dart';
import 'package:untitled/src/screens/payment%20confirm%20screen/payment_confirm_screen.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class PaymentScreen extends StatefulWidget {
  final ApartmentBill? apartmentBill;
  final ServiceBill? serviceBill;
  const PaymentScreen({Key? key, this.apartmentBill, this.serviceBill})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFCF6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB2F68),
        centerTitle: true,
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
        child: Column(
          children: [
            if (widget.apartmentBill != null)
              Column(
                children: [
                  ApartmentBillDetailContainer(
                      apartmentBill: widget.apartmentBill!),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFDB2F68),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(45),
                          bottomRight: Radius.circular(45),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          left: width * 0.07,
                          right: width * 0.06,
                          top: height * 0.012,
                          bottom: height * 0.012),
                      child: Text(
                        "Hướng dẫn thanh toán",
                        style: AppTextStyle.lato.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.01,
                      left: width * 0.04,
                      right: width * 0.04,
                      bottom: height * 0.03,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromRGBO(0, 0, 0, 0.2),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                      text:
                                          "Quý khách vui lòng chuyển khoản số tiền "),
                                  TextSpan(
                                    text: widget.apartmentBill!.price
                                        .toString()
                                        .formatMoney(),
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const TextSpan(text: " vào tài khoản sau:"),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Số tài khoản: ",
                                  ),
                                  TextSpan(
                                    text: "0123456789",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Chủ tài khoản: ",
                                  ),
                                  TextSpan(
                                    text: "Ban quản lý chung cư...",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Ngân hàng: ",
                                  ),
                                  TextSpan(
                                    text: "Ngân hàng Vietcombank",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Chi nhánh ngân hàng: ",
                                  ),
                                  TextSpan(
                                    text: "PGD Bến thành - Chi nhánh Sài Gòn",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Nội dung chuyển khoản: ",
                                  ),
                                  TextSpan(
                                    text: "DV210822-0123456789",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: width * 0.07,
                      right: width * 0.07,
                      bottom: height * 0.03,
                    ),
                    child: Text(
                      "Lưu ý: Quý khách vui lòng chuyển đúng số tiền và ghi đúng nội dung chuyển khoản",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.robotoSize14.copyWith(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentConfirmScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDB2F68),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: width * 0.35,
                          right: width * 0.35,
                          top: height * 0.015,
                          bottom: height * 0.015),
                      child: Text(
                        "Tiếp tục",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 15,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                ],
              ),
            if (widget.serviceBill != null)
              Column(
                children: [
                  ServiceBillDetailContainer(serviceBill: widget.serviceBill!),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFDB2F68),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(45),
                          bottomRight: Radius.circular(45),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          left: width * 0.07,
                          right: width * 0.06,
                          top: height * 0.012,
                          bottom: height * 0.012),
                      child: Text(
                        "Hướng dẫn thanh toán",
                        style: AppTextStyle.lato.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.01,
                      left: width * 0.04,
                      right: width * 0.04,
                      bottom: height * 0.03,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromRGBO(0, 0, 0, 0.2),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                      text:
                                          "Quý khách vui lòng chuyển khoản số tiền "),
                                  TextSpan(
                                    text: widget.serviceBill!.price
                                        .toString()
                                        .formatMoney(),
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const TextSpan(text: " vào tài khoản sau:"),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Số tài khoản: ",
                                  ),
                                  TextSpan(
                                    text: "0123456789",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Chủ tài khoản: ",
                                  ),
                                  TextSpan(
                                    text: "Ban quản lý chung cư...",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Ngân hàng: ",
                                  ),
                                  TextSpan(
                                    text: "Ngân hàng Vietcombank",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Chi nhánh ngân hàng: ",
                                  ),
                                  TextSpan(
                                    text: "PGD Bến thành - Chi nhánh Sài Gòn",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "· ",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Nội dung chuyển khoản: ",
                                  ),
                                  TextSpan(
                                    text: "DV210822-0123456789",
                                    style: AppTextStyle.lato.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: width * 0.07,
                      right: width * 0.07,
                      bottom: height * 0.03,
                    ),
                    child: Text(
                      "Lưu ý: Quý khách vui lòng chuyển đúng số tiền và ghi đúng nội dung chuyển khoản",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.robotoSize14.copyWith(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentConfirmScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDB2F68),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: width * 0.35,
                          right: width * 0.35,
                          top: height * 0.015,
                          bottom: height * 0.015),
                      child: Text(
                        "Tiếp tục",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 15,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                ],
              ),
          ],
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
                widget.serviceBill != null
                    ? Text(
                        widget.serviceBill!.price.toString().formatMoney(),
                        style: AppTextStyle.lato.copyWith(
                          color: const Color(0xFFFFFFFF),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : Text(
                        widget.apartmentBill!.price.toString().formatMoney(),
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

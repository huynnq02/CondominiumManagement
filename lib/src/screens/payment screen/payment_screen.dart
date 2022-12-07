import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/apartment_bill_container.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/widgets/service_bill_container.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            width * 0.05,
            height * 0.03,
            width * 0.05,
            width * 0.08,
          ),
          child: Column(
            children: [
              if (widget.apartmentBill != null)
                Column(
                  children: [
                    ApartmentBillDetailContainer(
                        apartmentBill: widget.apartmentBill!),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: Text(
                          "Hướng dẫn thanh toán",
                          style: AppTextStyle.lato.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF117B08).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Lưu ý: Quý khách vui lòng chuyển đúng số tiền và ghi đúng nội dung chuyển khoản",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.018,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D6D54),
                        borderRadius: BorderRadius.circular(10),
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
                          top: height * 0.012,
                          bottom: height * 0.012),
                      child: Text(
                        "Tiếp tục",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              if (widget.serviceBill != null)
                Column(
                  children: [
                    ServiceBillDetailContainer(
                        serviceBill: widget.serviceBill!),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: Text(
                          "Hướng dẫn thanh toán",
                          style: AppTextStyle.lato.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
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
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF117B08).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Lưu ý: Quý khách vui lòng chuyển đúng số tiền và ghi đúng nội dung chuyển khoản",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.018,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D6D54),
                        borderRadius: BorderRadius.circular(10),
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
                          top: height * 0.012,
                          bottom: height * 0.012),
                      child: Text(
                        "Tiếp tục",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

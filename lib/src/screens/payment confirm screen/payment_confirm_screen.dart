import 'package:flutter/material.dart';
import 'package:untitled/src/screens/payment%20confirm%20screen/widgets/custom_rich_text.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class PaymentConfirmScreen extends StatefulWidget {
  const PaymentConfirmScreen({Key? key}) : super(key: key);

  @override
  State<PaymentConfirmScreen> createState() => _PaymentConfirmScreenState();
}

class _PaymentConfirmScreenState extends State<PaymentConfirmScreen> {
  DateTime _dateTime = DateTime.now();
  // controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool isEmptyName = false,
      isEmptyAccountNumber = false,
      isEmptyBankName = false,
      isEmptyContent = false;
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
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.White,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: height * 0.01,
            left: width * 0.055,
            right: width * 0.055,
            bottom: height * 0.01),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: height * 0.02,
              ),
              child: Text(
                "Quý khách vui lòng cung cấp thông tin làm chứng cho việc đã chuyển khoản số tiền thanh toán vào tài khoản ngân hàng ban quản lí",
                style: AppTextStyle.lato.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.Black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CustomRichTextPayment("Tên chủ tài khoản", "*", 15),
                  SizedBox(height: height * 0.01),
                  Container(
                    height: height * 0.055,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isEmptyName ? AppColors.Red : AppColors.Black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // delete underline
                      ),
                    ),
                  ),
                  if (isEmptyName)
                    Column(
                      children: [
                        SizedBox(height: height * 0.005),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Vui lòng nhập tên chủ tài khoản",
                            style: AppTextStyle.lato
                                .copyWith(color: AppColors.Red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: height * 0.01),
                  CustomRichTextPayment("Số tài khoản", "*", 15),
                  SizedBox(height: height * 0.01),
                  Container(
                    height: height * 0.055,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isEmptyAccountNumber
                            ? AppColors.Red
                            : AppColors.Black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: accountNumberController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // delete underline
                      ),
                    ),
                  ),
                  if (isEmptyAccountNumber)
                    Column(
                      children: [
                        SizedBox(height: height * 0.005),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Vui lòng nhập số tài khoản",
                            style: AppTextStyle.lato
                                .copyWith(color: AppColors.Red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: height * 0.01),
                  CustomRichTextPayment("Ngân hàng", "*", 15),
                  SizedBox(height: height * 0.01),
                  Container(
                    height: height * 0.055,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isEmptyBankName ? AppColors.Red : AppColors.Black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: bankNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // delete underline
                      ),
                    ),
                  ),
                  if (isEmptyBankName)
                    Column(
                      children: [
                        SizedBox(height: height * 0.005),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Vui lòng nhập tên ngân hàng",
                            style: AppTextStyle.lato
                                .copyWith(color: AppColors.Red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: height * 0.01),
                  CustomRichTextPayment("Nội dung chuyển khoản", "*", 15),
                  SizedBox(height: height * 0.01),
                  Container(
                    height: height * 0.055,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isEmptyContent ? AppColors.Red : AppColors.Black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: contentController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // delete underline
                      ),
                    ),
                  ),
                  if (isEmptyContent)
                    Column(
                      children: [
                        SizedBox(height: height * 0.005),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Vui lòng nhập nội dung chuyển khoản",
                            style: AppTextStyle.lato
                                .copyWith(color: AppColors.Red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: height * 0.01),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ngày giao dịch",
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    height: height * 0.055,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.Black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}",
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: _dateTime,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((date) {
                              setState(() {
                                _dateTime = date!;
                              });
                            });
                          },
                          child: const Icon(
                            Icons.calendar_today,
                            color: AppColors.Black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            InkWell(
              onTap: () {
                setState(() {
                  isEmptyName = nameController.text.isEmpty;
                  isEmptyAccountNumber = accountNumberController.text.isEmpty;
                  isEmptyBankName = bankNameController.text.isEmpty;
                  isEmptyContent = contentController.text.isEmpty;
                });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.White,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.Black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(
                      color: AppColors.Black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/service_bill_detail.dart';
import 'package:untitled/src/screens/payment%20screen/payment_screen.dart';
import 'package:untitled/src/screens/payment%20screen/service_bill_office_payment_screen.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class ItemServiceBill extends StatefulWidget {
  final ServiceBill serviceBill;
  const ItemServiceBill({Key? key, required this.serviceBill})
      : super(key: key);

  @override
  State<ItemServiceBill> createState() => _ItemServiceBillState();
}

class _ItemServiceBillState extends State<ItemServiceBill> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceBillDetailScreen(
              serviceBill: widget.serviceBill,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: widget.serviceBill.state == "Đã thanh toán"
                ? const Color(0xFF2AC956)
                : widget.serviceBill.state == "Chưa thanh toán" ||
                        widget.serviceBill.state == "Từ chối thanh toán"
                    ? const Color(0xFFFFC000)
                    : const Color(0xFF5C92FE),
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              width * 0.018, height * 0.01, width * 0.03, height * 0.01),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.serviceBill.billName,
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Loại dịch vụ:",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            "Hạn đóng:",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.serviceBill.serviceName,
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            widget.serviceBill.paymentTerm.formatDateTime(),
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFF8A00),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    widget.serviceBill.price.toString().formatMoney(),
                    style: AppTextStyle.lato.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Black),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  widget.serviceBill.serviceName == "Ăn uống"
                      ? const Image(
                          image: AssetImage("assets/bbq.png"),
                        )
                      : widget.serviceBill.serviceName == "An ninh"
                          ? const Image(
                              image: AssetImage("assets/parking.png"),
                            )
                          : widget.serviceBill.serviceName == "Giải trí"
                              ? const Image(
                                  image: AssetImage("assets/game.png"),
                                )
                              : const Image(
                                  image: AssetImage("assets/gym.png"),
                                ),
                  SizedBox(
                    height: height * 0.023,
                  ),
                  Row(
                    children: [
                      widget.serviceBill.state == "Đã thanh toán"
                          ? Image.asset("assets/done-icon.png")
                          : widget.serviceBill.state == "Chưa thanh toán"
                              ? Image.asset("assets/warning-icon.png")
                              : widget.serviceBill.state == "Từ chối thanh toán"
                                  ? Image.asset("assets/refuse-icon.png")
                                  : Image.asset("assets/waiting-icon.png"),
                      const SizedBox(
                        width: 10,
                      ),
                      widget.serviceBill.state == "Đã thanh toán"
                          ? Text(
                              "Đã thanh toán",
                              style: AppTextStyle.lato.copyWith(
                                color: const Color(0xFF2AC956),
                              ),
                            )
                          : widget.serviceBill.state == "Từ chối thanh toán"
                              ? Text(
                                  "Từ chối thanh toán",
                                  style: AppTextStyle.lato.copyWith(
                                    color: const Color(0xFFFFC000),
                                  ),
                                )
                              : widget.serviceBill.state == "Chưa thanh toán"
                                  ? InkWell(
                                      onTap: _showModalBottomSheet,
                                      child: Container(
                                        height: height * 0.03,
                                        width: width * 0.20,
                                        child: Center(
                                          child: Text(
                                            "Thanh toán",
                                            style: AppTextStyle.lato.copyWith(
                                                color: AppColors.White),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFFFC000),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.25),
                                                offset: Offset(0, 3),
                                                blurRadius: 6,
                                              ),
                                            ]),
                                      ),
                                    )
                                  : Text(
                                      "Chờ tiếp nhận",
                                      style: AppTextStyle.lato.copyWith(
                                        color: const Color(0xFF5C92FE),
                                      ),
                                    ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (builder) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return Container(
          height: height * 0.197,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: height * 0.065,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Chọn phương thức thanh toán",
                    style: AppTextStyle.lato
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.001,
              ),
              Container(
                height: height * 0.065,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 35),
                            child: Image(
                              image: AssetImage(
                                  'assets/internet-banking-icon.png'),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chuyển khoản ngân hàng",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFF12C82F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            serviceBill: widget.serviceBill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.001,
              ),
              Container(
                height: height * 0.065,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 35),
                            child: Image(
                              image: AssetImage('assets/direct-debit-icon.png'),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Thanh toán tại văn phòng",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFF12C82F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceBillOfficePaymentScreen(
                            serviceBill: widget.serviceBill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

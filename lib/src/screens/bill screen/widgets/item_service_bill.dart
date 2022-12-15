import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/service_bill_detail.dart';
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
                : widget.serviceBill.state == "Chưa thanh toán"
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
                    widget.serviceBill.price.toString(),
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
                          : widget.serviceBill.state == "Chưa thanh toán"
                              ? Container(
                                  height: height * 0.03,
                                  width: width * 0.20,
                                  child: Center(
                                    child: Text(
                                      "Thanh toán",
                                      style: AppTextStyle.lato
                                          .copyWith(color: AppColors.White),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFFC000),
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        ),
                                      ]),
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
}

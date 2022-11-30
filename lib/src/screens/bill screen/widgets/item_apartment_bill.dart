import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class ItemApartmentBill extends StatefulWidget {
  final EandWBill eAndWBill;
  const ItemApartmentBill({Key? key, required this.eAndWBill})
      : super(key: key);

  @override
  State<ItemApartmentBill> createState() => _ItemApartmentBillState();
}

class _ItemApartmentBillState extends State<ItemApartmentBill> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(width * 0.02, 0, width * 0.02, 0),
      height: height * 0.11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: widget.eAndWBill.state == "Đã thanh toán"
              ? const Color(0xFF2AC956)
              : widget.eAndWBill.state == "Chưa thanh toán"
                  ? const Color(0xFFFFC000)
                  : const Color(0xFF5C92FE),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: widget.eAndWBill.billType == "Điện"
                ? Image.asset("assets/electricity-icon.png")
                : Image.asset("assets/water-icon.png"),
            flex: 1,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.eAndWBill.billName,
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hạn: " + widget.eAndWBill.paymentTerm.formatDateTime(),
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 11,
                    color: const Color(0xFFFF8A00),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.eAndWBill.price.toString() + "đ",
                style: AppTextStyle.lato.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.eAndWBill.state == "Đã thanh toán"
                      ? Image.asset("assets/done-icon.png")
                      : widget.eAndWBill.state == "Chưa thanh toán"
                          ? Image.asset("assets/warning-icon.png")
                          : Image.asset("assets/waiting-icon.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  widget.eAndWBill.state == "Đã thanh toán"
                      ? Text(
                          "Đã thanh toán",
                          style: AppTextStyle.lato.copyWith(
                            color: const Color(0xFF2AC956),
                          ),
                        )
                      : widget.eAndWBill.state == "Chưa thanh toán"
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ItemApartmentBill extends StatefulWidget {
  final Bill bill;
  const ItemApartmentBill({Key? key, required this.bill}) : super(key: key);

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
          color: widget.bill.state == "Đã thanh toán"
              ? const Color(0xFF2AC956)
              : widget.bill.state == "Chưa thanh toán"
                  ? const Color(0xFFFFC000)
                  : const Color(0xFF5C92FE),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: widget.bill.type == "Electricity"
                ? Image.asset("assets/electricity-icon.png")
                : widget.bill.type == "Water"
                    ? Image.asset("assets/water-icon.png")
                    : widget.bill.type == "Garbage"
                        ? Image.asset("assets/garbage-icon.png")
                        : Image.asset("assets/management-icon.png"),
            flex: 1,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.bill.name,
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hạn: " + widget.bill.deadline,
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
                widget.bill.price,
                style: AppTextStyle.lato.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.bill.state == "Đã thanh toán"
                      ? Image.asset("assets/done-icon.png")
                      : widget.bill.state == "Chưa thanh toán"
                          ? Image.asset("assets/warning-icon.png")
                          : Image.asset("assets/waiting-icon.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  widget.bill.state == "Đã thanh toán"
                      ? Text(
                          "Đã thanh toán",
                          style: AppTextStyle.lato.copyWith(
                            color: const Color(0xFF2AC956),
                          ),
                        )
                      : widget.bill.state == "Chưa thanh toán"
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

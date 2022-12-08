import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/apartment_bill_detail.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class ItemAparmentBill extends StatefulWidget {
  final ApartmentBill apartmentBill;
  const ItemAparmentBill({Key? key, required this.apartmentBill})
      : super(key: key);

  @override
  State<ItemAparmentBill> createState() => _ItemAparmentBillState();
}

class _ItemAparmentBillState extends State<ItemAparmentBill> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApartmentBillDetailScreen(
              apartmentBill: widget.apartmentBill,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(width * 0.02, 0, width * 0.02, 0),
        height: height * 0.11,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: widget.apartmentBill.state == "Đã thanh toán"
                ? const Color(0xFF2AC956)
                : widget.apartmentBill.state == "Chưa thanh toán"
                    ? const Color(0xFFFFC000)
                    : const Color(0xFF5C92FE),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: widget.apartmentBill.billType == "Điện"
                  ? Image.asset("assets/electricity-icon.png")
                  : widget.apartmentBill.billType == "Nước"
                      ? Image.asset("assets/water-icon.png")
                      : widget.apartmentBill.billType == "Rác"
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
                    widget.apartmentBill.billName,
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hạn: " + widget.apartmentBill.paymentTerm.formatDateTime(),
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
                  widget.apartmentBill.price.toString() + "đ",
                  style: AppTextStyle.lato.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    widget.apartmentBill.state == "Đã thanh toán"
                        ? Image.asset("assets/done-icon.png")
                        : widget.apartmentBill.state == "Chưa thanh toán"
                            ? Image.asset("assets/warning-icon.png")
                            : Image.asset("assets/waiting-icon.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    widget.apartmentBill.state == "Đã thanh toán"
                        ? Text(
                            "Đã thanh toán",
                            style: AppTextStyle.lato.copyWith(
                              color: const Color(0xFF2AC956),
                            ),
                          )
                        : widget.apartmentBill.state == "Chưa thanh toán"
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
    );
  }
}

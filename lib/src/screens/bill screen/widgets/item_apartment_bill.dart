import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20detail%20screen/apartment_bill_detail.dart';
import 'package:untitled/src/screens/payment%20screen/apartment_bill_office_payment_screen.dart';
import 'package:untitled/src/screens/payment%20screen/payment_screen.dart';
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
        if (widget.apartmentBill.state == "Chưa thanh toán") {
          _showModalBottomSheet();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ApartmentBillDetailScreen(
                apartmentBill: widget.apartmentBill,
              ),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(width * 0.02, 0, width * 0.02, 0),
        height: height * 0.11,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDFD),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (widget.apartmentBill.billType != "Nước")
              SizedBox(
                width: width * 0.018,
              ),
            widget.apartmentBill.billType == "Điện"
                ? Image.asset("assets/electricity-icon.png")
                : widget.apartmentBill.billType == "Nước"
                    ? Image.asset("assets/water-icon.png")
                    : widget.apartmentBill.billType == "Rác"
                        ? Image.asset("assets/garbage-icon.png")
                        : Image.asset("assets/management-icon.png"),
            SizedBox(
              width: width * 0.02,
            ),
            if (widget.apartmentBill.billType != "Điện")
              SizedBox(
                width: width * 0.018,
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.apartmentBill.billName ?? "Không có tên",
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF756969),
                  ),
                ),
                SizedBox(
                  height: height * 0.013,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Hạn: ",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF756969),
                        ),
                      ),
                      TextSpan(
                        text: widget.apartmentBill.paymentTerm.formatDateTime(),
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF756969),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.apartmentBill.price.toString().formatMoney(),
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF756969),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                widget.apartmentBill.state == "Đã thanh toán"
                    ? Text(
                        "Đã thanh toán",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4AC53F),
                        ),
                      )
                    : widget.apartmentBill.state == "Từ chối thanh toán"
                        ? Text(
                            "Từ chối thanh toán",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFDD3C63),
                            ),
                          )
                        : widget.apartmentBill.state == "Chưa thanh toán"
                            ? Text(
                                "Chưa thanh toán",
                                style: AppTextStyle.lato.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFF47D00),
                                ),
                              )
                            : Text(
                                "Chờ tiếp nhận",
                                style: AppTextStyle.lato.copyWith(
                                  color: const Color(0xFF578DCB),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
              ],
            )
          ],
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
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
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
                              color: const Color(0xFFD0255E),
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
                            apartmentBill: widget.apartmentBill,
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
                              color: const Color(0xFFD0255E),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ApartmentBillOfficePaymentScreen(
                            apartmentBill: widget.apartmentBill,
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

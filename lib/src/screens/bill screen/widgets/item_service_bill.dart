import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ItemServiceBill extends StatefulWidget {
  final Bill bill;
  const ItemServiceBill({Key? key, required this.bill}) : super(key: key);

  @override
  State<ItemServiceBill> createState() => _ItemServiceBillState();
}

class _ItemServiceBillState extends State<ItemServiceBill> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(width * 0.02, 0, 10, 0),
      height: height * 0.2,
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
      child: Padding(
        padding:
            EdgeInsets.fromLTRB(width * 0.015, height * 0.02, width * 0.015, 0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.bill.name,
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Loại dịch vụ:",
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          "Hạn đóng:",
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.bill.type,
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          widget.bill.deadline,
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 15,
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
                  widget.bill.price,
                  style: AppTextStyle.lato.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.Black),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // widget.bill.type == "Ăn uống"
                //     ? const Image(
                //         image: AssetImage("assets/bbq.png"),
                //       )
                //     : widget.bill.type == "An ninh"
                //         ? const Image(
                //             image: AssetImage("assets/parking.png"),
                //           )
                //         : widget.bill.type == "Giải trí"
                //             ? const Image(
                //                 image: AssetImage("assets/game.png"),
                //               )
                //             : const Image(
                //                 image: AssetImage("assets/gym.png"),
                //               ),
                Image(
                  image: const AssetImage("assets/water-icon.png"),
                  height: height * 0.1,
                  width: width * 0.4,
                ),
                SizedBox(
                  height: height * 0.023,
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
      ),
    );
  }
}

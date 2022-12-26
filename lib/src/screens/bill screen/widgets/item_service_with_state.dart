import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/item_service_bill.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ItemServiceWithState extends StatefulWidget {
  String state;
  List<ServiceBill> serviceBills;
  ItemServiceWithState(
      {required this.serviceBills, required this.state, Key? key})
      : super(key: key);

  @override
  State<ItemServiceWithState> createState() => _ItemWithStateState();
}

class _ItemWithStateState extends State<ItemServiceWithState> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${widget.state} (${widget.serviceBills.length})",
            style: AppTextStyle.lato.copyWith(
              color: const Color(0xFF979A9C),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        widget.serviceBills.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.03),
                child: Text(
                  "Không tìm thấy hóa đơn nào",
                  style: AppTextStyle.lato.copyWith(
                    color: const Color(0xFF979A9C),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.serviceBills.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: ItemServiceBill(
                      serviceBill: widget.serviceBills[index],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/item_service_bill.dart';

class ServiceBill extends StatefulWidget {
  const ServiceBill({Key? key}) : super(key: key);

  @override
  State<ServiceBill> createState() => _ServiceBillState();
}

class _ServiceBillState extends State<ServiceBill> {
  final List<Bill> bills = [
    Bill(
        name: "Dịch vụ BBQ",
        type: "Ăn uống",
        deadline: "15/10/2022",
        price: "500.000đ",
        state: "Chưa thanh toán"),
    Bill(
        name: "Trông giữ xe",
        type: "An ninh",
        deadline: "15/10/2022",
        price: "200.000đ",
        state: "Chờ tiếp nhận"),
    Bill(
        name: "Phòng game",
        type: "Giải trí",
        deadline: "15/10/2022",
        price: "50.000đ",
        state: "Đã thanh toán"),
    Bill(
        name: "Phòng gym",
        type: "Khác",
        deadline: "15/10/2022",
        price: "100.000đ",
        state: "Đã thanh toán"),
  ];
  @override
  Widget build(BuildContext context) => Container(
        child: ListView.builder(
          itemCount: bills.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ItemServiceBill(
              bill: bills[index],
            ),
          ),
        ),
      );
}

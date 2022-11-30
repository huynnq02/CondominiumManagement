import 'package:flutter/material.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/item_apartment_bill.dart';

class ApartmentBill extends StatefulWidget {
  const ApartmentBill({Key? key}) : super(key: key);

  @override
  State<ApartmentBill> createState() => _ApartmentBillState();
}

class _ApartmentBillState extends State<ApartmentBill> {
  final List<Bill> bills = [
    Bill(
        name: "Hóa đơn điện 10/2022",
        type: "Electricity",
        deadline: "15/10/2022",
        price: "500.000đ",
        state: "Chưa thanh toán"),
    Bill(
        name: "Hóa đơn nước 10/2022",
        type: "Water",
        deadline: "15/10/2022",
        price: "200.000đ",
        state: "Chờ tiếp nhận"),
    Bill(
        name: "Phí dọn rác 09/2022",
        type: "Garbage",
        deadline: "15/10/2022",
        price: "50.000đ",
        state: "Đã thanh toán"),
    Bill(
        name: "Phí QL chung cư 09/2022",
        type: "Management",
        deadline: "15/10/2022",
        price: "100.000đ",
        state: "Đã thanh toán"),
    Bill(
        name: "Hóa đơn điện 09/2022",
        type: "Electricity",
        deadline: "15/10/2022",
        price: "500.000đ",
        state: "Chưa thanh toán"),
    Bill(
        name: "Hóa đơn nước 09/2022",
        type: "Water",
        deadline: "15/10/2022",
        price: "200.000đ",
        state: "Chờ tiếp nhận"),
  ];
  @override
  Widget build(BuildContext context) => Container(
        child: ListView.builder(
          itemCount: bills.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ItemApartmentBill(
              bill: bills[index],
            ),
          ),
        ),
      );
}

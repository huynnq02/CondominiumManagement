import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/providers/bill_provider.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/item_apartment_bill.dart';

class AparmentBilll extends StatefulWidget {
  const AparmentBilll({Key? key}) : super(key: key);

  @override
  State<AparmentBilll> createState() => _AparmentBilllState();
}

class _AparmentBilllState extends State<AparmentBilll> {
  // final List<Bill> bills = [
  //   Bill(
  //       name: "Hóa đơn điện 10/2022",
  //       type: "Electricity",
  //       deadline: "15/10/2022",
  //       price: "500.000đ",
  //       state: "Chưa thanh toán"),
  //   Bill(
  //       name: "Hóa đơn nước 10/2022",
  //       type: "Water",
  //       deadline: "15/10/2022",
  //       price: "200.000đ",
  //       state: "Chờ tiếp nhận"),
  //   Bill(
  //       name: "Phí dọn rác 09/2022",
  //       type: "Garbage",
  //       deadline: "15/10/2022",
  //       price: "50.000đ",
  //       state: "Đã thanh toán"),
  //   Bill(
  //       name: "Phí QL chung cư 09/2022",
  //       type: "Management",
  //       deadline: "15/10/2022",
  //       price: "100.000đ",
  //       state: "Đã thanh toán"),
  //   Bill(
  //       name: "Hóa đơn điện 09/2022",
  //       type: "Electricity",
  //       deadline: "15/10/2022",
  //       price: "500.000đ",
  //       state: "Chưa thanh toán"),
  //   Bill(
  //       name: "Hóa đơn nước 09/2022",
  //       type: "Water",
  //       deadline: "15/10/2022",
  //       price: "200.000đ",
  //       state: "Chờ tiếp nhận"),
  // ];
  @override
  Widget build(BuildContext context) {
    final aparmentBills =
        Provider.of<BillProvider>(context, listen: false).apartmentBills;

    return Container(
      child: ListView.builder(
        itemCount: aparmentBills.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: ItemAparmentBill(
              aparmentBill: aparmentBills[index],
            )

            // ItemAparmentBilll(
            //     manageBill: bills[index],
            //   ),
            ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/providers/bill_provider.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/item_apartment_bill.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/item_apartment_with_state.dart';

class AparmentBill extends StatefulWidget {
  const AparmentBill({Key? key}) : super(key: key);

  @override
  State<AparmentBill> createState() => _AparmentBillState();
}

class _AparmentBillState extends State<AparmentBill> {
  int itemCount(String state) {
    if (state == 'Tất cả') {
      return Provider.of<BillProvider>(context, listen: false)
          .apartmentBills
          .length;
    } else if (state == 'Chưa thanh toán') {
      return Provider.of<BillProvider>(context, listen: false)
          .unpaidApartmentBills
          .length;
    } else if (state == 'Đã thanh toán') {
      return Provider.of<BillProvider>(context, listen: false)
          .paidApartmentBills
          .length;
    } else if (state == 'Từ chối thanh toán') {
      return Provider.of<BillProvider>(context, listen: false)
          .refuseApartmentBills
          .length;
    } else {
      return Provider.of<BillProvider>(context, listen: false)
          .waitingApartmentBills
          .length;
    }
  }

  @override
  Widget build(BuildContext context) {
    final aparmentBills =
        Provider.of<BillProvider>(context, listen: false).apartmentBills;
    final paidApartmentBills =
        Provider.of<BillProvider>(context, listen: false).paidApartmentBills;
    final unpaidApartmentBills =
        Provider.of<BillProvider>(context, listen: false).unpaidApartmentBills;
    final refuseApartmentBills =
        Provider.of<BillProvider>(context, listen: false).refuseApartmentBills;
    final waitingApartmentBills =
        Provider.of<BillProvider>(context, listen: false).waitingApartmentBills;
    return SingleChildScrollView(
      child: Column(
        children: [
          if (Provider.of<BillProvider>(context).billState == "Tất cả")
            ItemApartmentWithState(
                apartmentBills: unpaidApartmentBills, state: "Chưa thanh toán"),
          if (Provider.of<BillProvider>(context).billState == "Tất cả")
            ItemApartmentWithState(
                apartmentBills: waitingApartmentBills, state: "Chờ tiếp nhận"),
          if (Provider.of<BillProvider>(context).billState == "Tất cả")
            ItemApartmentWithState(
                apartmentBills: refuseApartmentBills,
                state: "Từ chối thanh toán"),
          if (Provider.of<BillProvider>(context).billState == "Tất cả")
            ItemApartmentWithState(
                apartmentBills: paidApartmentBills, state: "Đã thanh toán"),
          if (Provider.of<BillProvider>(context).billState == "Chưa thanh toán")
            ItemApartmentWithState(
                apartmentBills: unpaidApartmentBills, state: "Chưa thanh toán"),
          if (Provider.of<BillProvider>(context).billState == "Đã thanh toán")
            ItemApartmentWithState(
                apartmentBills: paidApartmentBills, state: "Đã thanh toán"),
          if (Provider.of<BillProvider>(context).billState ==
              "Từ chối thanh toán")
            ItemApartmentWithState(
                apartmentBills: refuseApartmentBills,
                state: "Từ chối thanh toán"),
          if (Provider.of<BillProvider>(context).billState == "Chờ tiếp nhận")
            ItemApartmentWithState(
                apartmentBills: waitingApartmentBills, state: "Chờ tiếp nhận"),
        ],
      ),
    );
    // return Container(
    //   child: ListView.builder(
    //     itemCount: itemCount(Provider.of<BillProvider>(context).billState),
    //     itemBuilder: (context, index) => Padding(
    //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
    //       child: ItemAparmentBill(
    //           apartmentBill:
    //               Provider.of<BillProvider>(context).billState == 'Tất cả'
    //                   ? aparmentBills[index]
    //                   : Provider.of<BillProvider>(context).billState ==
    //                           'Chưa thanh toán'
    //                       ? Provider.of<BillProvider>(context)
    //                           .unpaidApartmentBills[index]
    //                       : Provider.of<BillProvider>(context).billState ==
    //                               'Đã thanh toán'
    //                           ? Provider.of<BillProvider>(context)
    //                               .paidApartmentBills[index]
    //                           : Provider.of<BillProvider>(context).billState ==
    //                                   'Từ chối thanh toán'
    //                               ? Provider.of<BillProvider>(context)
    //                                   .refuseApartmentBills[index]
    //                               : Provider.of<BillProvider>(context)
    //                                   .waitingApartmentBills[index]),
    //     ),
    //   ),
    // );
  }
}

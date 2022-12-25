import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/providers/bill_provider.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/item_apartment_bill.dart';

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
    return ListView(
      // display item with group state
      children: List.generate(
        itemCount(Provider.of<BillProvider>(context).billState),
        (index) => Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: ItemAparmentBill(
              apartmentBill:
                  Provider.of<BillProvider>(context).billState == 'Tất cả'
                      ? aparmentBills[index]
                      : Provider.of<BillProvider>(context).billState ==
                              'Chưa thanh toán'
                          ? Provider.of<BillProvider>(context)
                              .unpaidApartmentBills[index]
                          : Provider.of<BillProvider>(context).billState ==
                                  'Đã thanh toán'
                              ? Provider.of<BillProvider>(context)
                                  .paidApartmentBills[index]
                              : Provider.of<BillProvider>(context).billState ==
                                      'Từ chối thanh toán'
                                  ? Provider.of<BillProvider>(context)
                                      .refuseApartmentBills[index]
                                  : Provider.of<BillProvider>(context)
                                      .waitingApartmentBills[index]),
        ),
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

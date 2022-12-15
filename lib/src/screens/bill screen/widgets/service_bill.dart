import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/bill.dart';
import 'package:untitled/src/providers/bill_provider.dart';
import 'package:untitled/src/screens/bill%20screen/widgets/item_service_bill.dart';

class ServiceBill extends StatefulWidget {
  const ServiceBill({Key? key}) : super(key: key);

  @override
  State<ServiceBill> createState() => _ServiceBillState();
}

class _ServiceBillState extends State<ServiceBill> {
  int itemCount(String state) {
    if (state == 'Tất cả') {
      return Provider.of<BillProvider>(context, listen: false)
          .serviceBills
          .length;
    } else if (state == 'Chưa thanh toán') {
      return Provider.of<BillProvider>(context, listen: false)
          .unpaidServiceBills
          .length;
    } else if (state == 'Đã thanh toán') {
      return Provider.of<BillProvider>(context, listen: false)
          .paidServiceBills
          .length;
    } else {
      return Provider.of<BillProvider>(context, listen: false)
          .waitingServiceBills
          .length;
    }
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   Provider.of<BillProvider>(context, listen: false)
    //       .setStateProvider("Tất cả");
    // });
    final serviceBills = Provider.of<BillProvider>(context).serviceBills;
    final paidServiceBills =
        Provider.of<BillProvider>(context).paidServiceBills;
    final unpaidServiceBills =
        Provider.of<BillProvider>(context).unpaidServiceBills;
    final waitingServiceBills =
        Provider.of<BillProvider>(context).waitingServiceBills;

    return Container(
      child: ListView.builder(
        itemCount: itemCount(Provider.of<BillProvider>(context).billState),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: ItemServiceBill(
            serviceBill:
                Provider.of<BillProvider>(context).billState == 'Tất cả'
                    ? serviceBills[index]
                    : Provider.of<BillProvider>(context).billState ==
                            'Chưa thanh toán'
                        ? unpaidServiceBills[index]
                        : Provider.of<BillProvider>(context).billState ==
                                'Đã thanh toán'
                            ? paidServiceBills[index]
                            : waitingServiceBills[index],
          ),
        ),
      ),
    );
  }
}

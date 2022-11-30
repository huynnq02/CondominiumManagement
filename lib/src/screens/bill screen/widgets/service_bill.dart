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
  @override
  Widget build(BuildContext context) {
    final serviceBills =
        Provider.of<BillProvider>(context, listen: true).ServiceBills;
    return Container(
      child: ListView.builder(
        itemCount: serviceBills.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: ItemServiceBill(
            serviceBill: serviceBills[index],
          ),
        ),
      ),
    );
  }
}

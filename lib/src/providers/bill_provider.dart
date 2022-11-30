import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/repository/bill/billAPI_provider.dart';
import 'package:untitled/src/models/bill.dart' as bill;

class BillProvider extends ChangeNotifier {
  final List<bill.EandWBill> _eAndWBills = []; // Water and Electricity
  final List<bill.ServiceBill> _serviceBills = [];
  final List<bill.ManageBill> _manageBills = [];
  String _billState = "Tất cả";
  List<bill.EandWBill> get eAndWBills => _eAndWBills;
  List<bill.ServiceBill> get ServiceBills => _serviceBills;
  String get billState => _billState;
  void setEAndWBill(List<bill.EandWBill> eAndWBills) {
    _eAndWBills.clear();
    _eAndWBills.addAll(eAndWBills);
    notifyListeners();
  }

  void setStateProvider(String billState) {
    _billState = billState;
    notifyListeners();
  }

  void setServiceBills(List<bill.ServiceBill> serviceBills) {
    _serviceBills.clear();
    _serviceBills.addAll(serviceBills);
    notifyListeners();
  }

  Future getAllEAndWBill() async {
    print("ok");
    var res = await BillAPIProvider().getAllEAndWAPIRepository();
    // print(res);
    List<bill.EandWBill> eAndWBills = [];
    for (var item in res) {
      eAndWBills.add(bill.EandWBill.fromMap(item));
    }
    setEAndWBill(eAndWBills);
  }

  Future getAllServiceBill() async {
    final res = await BillAPIProvider().getAllServiceBillAPIRepository();
    print(res);
    List<bill.ServiceBill> serviceBills = [];
    for (var item in res) {
      serviceBills.add(bill.ServiceBill.fromMap(item));
    }
    setServiceBills(serviceBills);
  }
}

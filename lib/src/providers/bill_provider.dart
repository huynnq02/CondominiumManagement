import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/repository/bill/billAPI_provider.dart';
import 'package:untitled/src/models/bill.dart' as bill;

class BillProvider extends ChangeNotifier {
  final List<bill.AparmentBill> _apartmentBills = []; // Water and Electricity
  final List<bill.ServiceBill> _serviceBills = [];
  String _billState = "Tất cả";
  List<bill.AparmentBill> get apartmentBills => _apartmentBills;
  List<bill.ServiceBill> get serviceBills => _serviceBills;
  String get billState => _billState;
  void setApartmentBill(List<bill.AparmentBill> apartmentBills) {
    _apartmentBills.clear();
    _apartmentBills.addAll(apartmentBills);
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

  Future getAllApartmentBill() async {
    print("ok");
    var res = await BillAPIProvider().getAllApartmentBillAPIProvider();
    // print(res);
    List<bill.AparmentBill> apartmentBills = [];
    for (var item in res) {
      apartmentBills.add(bill.AparmentBill.fromMap(item));
    }
    setApartmentBill(apartmentBills);
  }

  Future getAllServiceBill() async {
    final res = await BillAPIProvider().getAllServiceBillAPIProvider();
    print(res);
    List<bill.ServiceBill> serviceBills = [];
    for (var item in res) {
      serviceBills.add(bill.ServiceBill.fromMap(item));
    }
    setServiceBills(serviceBills);
  }
}

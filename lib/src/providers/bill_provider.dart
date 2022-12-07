import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/repository/bill/billAPI_provider.dart';
import 'package:untitled/src/models/bill.dart' as bill;

class BillProvider extends ChangeNotifier {
  final List<bill.AparmentBill> _apartmentBills = [];
  final List<bill.AparmentBill> _paidApartmentBills = [];
  final List<bill.AparmentBill> _unpaidApartmentBills = [];
  final List<bill.AparmentBill> _waitingApartmentBills = [];

  final List<bill.ServiceBill> _serviceBills = [];
  final List<bill.ServiceBill> _paidServiceBills = [];
  final List<bill.ServiceBill> _unpaidServiceBills = [];
  final List<bill.ServiceBill> _waitingServiceBills = [];
  int _currentTab = 0;
  String _billState = "Tất cả";
  int get currentTab => _currentTab;
  List<bill.AparmentBill> get apartmentBills => _apartmentBills;
  List<bill.AparmentBill> get paidApartmentBills => _paidApartmentBills;
  List<bill.AparmentBill> get unpaidApartmentBills => _unpaidApartmentBills;
  List<bill.AparmentBill> get waitingApartmentBills => _waitingApartmentBills;

  List<bill.ServiceBill> get serviceBills => _serviceBills;
  List<bill.ServiceBill> get paidServiceBills => _paidServiceBills;
  List<bill.ServiceBill> get unpaidServiceBills => _unpaidServiceBills;
  List<bill.ServiceBill> get waitingServiceBills => _waitingServiceBills;

  String get billState => _billState;
  void setApartmentBill(List<bill.AparmentBill> apartmentBills) {
    _apartmentBills.clear();
    _apartmentBills.addAll(apartmentBills);
    setApartmentBillWithState();
    notifyListeners();
  }

  void setStateProvider(String billState) {
    _billState = billState;
    notifyListeners();
  }

  void setCurrentTab(int index) {
    _currentTab = index;
    notifyListeners();
  }

  void setServiceBillWithState() {
    _paidServiceBills.clear();
    _unpaidServiceBills.clear();
    _waitingServiceBills.clear();
    for (var item in _serviceBills) {
      if (item.state == "Đã thanh toán") {
        _paidServiceBills.add(item);
      } else if (item.state == "Chưa thanh toán") {
        _unpaidServiceBills.add(item);
      } else {
        _waitingServiceBills.add(item);
      }
    }
    notifyListeners();
  }

  void setApartmentBillWithState() {
    _paidApartmentBills.clear();
    _unpaidApartmentBills.clear();
    _waitingApartmentBills.clear();
    for (var item in _apartmentBills) {
      if (item.state == "Đã thanh toán") {
        _paidApartmentBills.add(item);
      } else if (item.state == "Chưa thanh toán") {
        _unpaidApartmentBills.add(item);
      } else {
        _waitingApartmentBills.add(item);
      }
    }
    notifyListeners();
  }

  void setServiceBills(List<bill.ServiceBill> serviceBills) {
    _serviceBills.clear();
    _serviceBills.addAll(serviceBills);
    setServiceBillWithState();
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

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/repository/bill/billAPI_provider.dart';
import 'package:untitled/src/models/bill.dart' as bill;
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/utils/helper/storage_methods.dart';
import 'package:untitled/utils/helper/show_snack_bar.dart';

class BillProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  final List<bill.ApartmentBill> _apartmentBills = [];
  final List<bill.ApartmentBill> _paidApartmentBills = [];
  final List<bill.ApartmentBill> _unpaidApartmentBills = [];
  final List<bill.ApartmentBill> _waitingApartmentBills = [];
  final List<bill.ApartmentBill> _refuseApartmentBills = [];

  final List<bill.ServiceBill> _serviceBills = [];
  final List<bill.ServiceBill> _paidServiceBills = [];
  final List<bill.ServiceBill> _unpaidServiceBills = [];
  final List<bill.ServiceBill> _waitingServiceBills = [];
  final List<bill.ServiceBill> _refuseServiceBills = [];
  int _currentTab = 0;
  String _billState = "Tất cả";
  int get currentTab => _currentTab;
  List<bill.ApartmentBill> get apartmentBills => _apartmentBills;
  List<bill.ApartmentBill> get paidApartmentBills => _paidApartmentBills;
  List<bill.ApartmentBill> get unpaidApartmentBills => _unpaidApartmentBills;
  List<bill.ApartmentBill> get waitingApartmentBills => _waitingApartmentBills;
  List<bill.ApartmentBill> get refuseApartmentBills => _refuseApartmentBills;

  List<bill.ServiceBill> get serviceBills => _serviceBills;
  List<bill.ServiceBill> get paidServiceBills => _paidServiceBills;
  List<bill.ServiceBill> get unpaidServiceBills => _unpaidServiceBills;
  List<bill.ServiceBill> get waitingServiceBills => _waitingServiceBills;
  List<bill.ServiceBill> get refuseServiceBills => _refuseServiceBills;

  String get billState => _billState;
  void setApartmentBill(List<bill.ApartmentBill> apartmentBills) {
    _apartmentBills.clear();
    _apartmentBills.addAll(apartmentBills);
    setApartmentBillWithState();
    notifyListeners();
    print(waitingApartmentBills.length);
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
      } else if (item.state == "Từ chối thanh toán") {
        _refuseServiceBills.add(item);
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
    _refuseApartmentBills.clear(); //
    for (var item in _apartmentBills) {
      if (item.state == "Đã thanh toán") {
        _paidApartmentBills.add(item);
      } else if (item.state == "Chưa thanh toán") {
        _unpaidApartmentBills.add(item);
      } else if (item.state == "Từ chối thanh toán") {
        _refuseApartmentBills.add(item);
      } else {
        _waitingApartmentBills.add(item);
      }
    }
    notifyListeners();
  }

  void updateApartmentBill(bill.ApartmentBill apartmentBill) {
    for (var item in _apartmentBills) {
      if (item.id == apartmentBill.id) {
        item.state = "Chờ tiếp nhận";
      }
    }
    setApartmentBillWithState();
    notifyListeners();
  }

  void updateServiceBill(bill.ServiceBill serviceBill) {
    for (var item in _serviceBills) {
      if (item.id == serviceBill.id) {
        item.state = "Chờ tiếp nhận";
      }
    }
    setServiceBillWithState();
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
    List<bill.ApartmentBill> apartmentBills = [];
    for (var item in res) {
      apartmentBills.add(bill.ApartmentBill.fromMap(item));
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

  Future editApartmentBill(BuildContext context, PickedFile _imageFile,
      bill.ApartmentBill apartmentBill) async {
    setIsLoading(true);
    final success =
        await BillAPIProvider().editApartmentBillAPIProvider(apartmentBill);
    print(success);
    print("done");

    if (success == true) {
      updateApartmentBill(apartmentBill);
      print("done1");

      uploadImage(context, _imageFile, "apartmentBillPaymentConfirmations");
      print("done2");
      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop();
      showSnackBar(context, "Đã gửi cho ban quản lí");
    } else {
      showSnackBar(context, "Gửi thất bại");
    }
    setIsLoading(false);
  }

  Future editServiceBill(BuildContext context, PickedFile _imageFile,
      bill.ServiceBill serviceBill) async {
    setIsLoading(true);
    final success =
        await BillAPIProvider().editServiceBillAPIProvider(serviceBill);
    print(success);
    print("done");

    if (success == true) {
      updateServiceBill(serviceBill);
      print("done1");

      uploadImage(context, _imageFile, 'serviceBillPaymentConfirmations');
      print("done2");
      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop();
      showSnackBar(context, "Đã gửi cho ban quản lí");
    } else {
      showSnackBar(context, "Gửi thất bại");
    }
    setIsLoading(false);
  }

  void uploadImage(
      BuildContext context, PickedFile _imageFile, String name) async {
    final user = context.read<ProfileProvider>().mdUser;
    final _image = File(_imageFile.path);
    Uint8List paymentConfirmation = await _image.readAsBytes();
    String imageUrl = await StorageMethods()
        .uploadImageToStorage(name, paymentConfirmation, false, user.idNumber);
    print(imageUrl);
  }
}

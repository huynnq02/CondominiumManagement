import 'package:flutter/cupertino.dart';
import 'package:untitled/src/models/phone.dart';

class CompareProvider extends ChangeNotifier {
  late Phone? phone1;
  Phone? phone2 = null;
// lưu thông tin điện thoại
  void setPhone1(Phone phone) {
    phone1 = phone;
    ChangeNotifier();
  }

  void setPhone2(Phone phone) {
    phone2 = phone;
    ChangeNotifier();
  }

//xóa thông tin điện thoại
  void removePhone1() {
    phone1 = null;
    notifyListeners();
  }

  void removePhone2() {
    phone2 = null;
    notifyListeners();
  }
}

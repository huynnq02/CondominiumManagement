import 'package:flutter/cupertino.dart';
import 'package:untitled/src/models/phone.dart';

class DashBoardPaginatorProvider extends ChangeNotifier {
  int state = 1;
  //thay đổi số thứ tự phân trang
  void onchange(int state) {
    this.state = state;
    notifyListeners();
  }

  var listSortPhone = [];
  Future<List> fetchPhone(List<Phone> input) async {
    var lst = input;
    var fake = [];
    int sizeList = 5;

    for (var i = 0; i < lst.length; i += sizeList) {
      fake.add(lst.sublist(
          i, i + sizeList > lst.length ? lst.length : i + sizeList));
    }
    listSortPhone = fake;
    fake = [];
    return listSortPhone;
  }
}

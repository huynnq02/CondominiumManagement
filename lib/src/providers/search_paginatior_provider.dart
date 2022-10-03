import 'package:flutter/widgets.dart';

import '../models/phone.dart';

class SearchPaginatorProvider extends ChangeNotifier {
  int state = 1;
  void onchange(int state) {
    this.state = state;
    notifyListeners();
  }

  var listSortPhone = [];

  fetchPhone(List<Phone> input) {
    listSortPhone = [];
    var lst = input;
//số lượng sản phẩm hiển thị ở 1 trang
    int sizeList = 10;

    for (var i = 0; i < lst.length; i += sizeList) {
      listSortPhone.add(lst.sublist(
          i, i + sizeList > lst.length ? lst.length : i + sizeList));
    }
  }
}

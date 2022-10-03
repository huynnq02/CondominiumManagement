import 'package:flutter/cupertino.dart';
import 'package:untitled/src/models/phone.dart';

class FavPaginatorProvider extends ChangeNotifier {
  int state = 1;
  void onchange(int state) {
    this.state = state;
    notifyListeners();
  }

  var listSortPhone = [];
  bool check = false;
  fetchPhone(List<Phone> input) {
    List phoneFake = [];
    var lst = input;

    int sizeList = 5;

    for (var i = 0; i < lst.length; i += sizeList) {
      phoneFake.add(lst.sublist(
          i, i + sizeList > lst.length ? lst.length : i + sizeList));
    }
    listSortPhone = phoneFake;
    phoneFake = [];
  }
}

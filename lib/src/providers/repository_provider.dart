import 'package:flutter/cupertino.dart';
import 'package:untitled/repository/phone/phone_provider.dart';

import '../models/phone.dart';

class RepositoryProvider extends ChangeNotifier {
  List<Phone> phones = [];
  Future<List<Phone>> getPhones() async {
    phones = await PhoneProvider().get();
//test login
    notifyListeners();
    return phones;
  }

  List<Phone> listSearch = [];
  searchPhone(String text) {
    listSearch = phones
        .where((element) =>
            element.name!.toUpperCase().contains(text.toUpperCase()))
        .toList();
  }

  var listSortPhone = [];
  fetchPhone(List<Phone> input) {
    var lst = input;

    int sizeList = 10;
// subList khi phân trang
    for (var i = 0; i < lst.length; i += sizeList) {
      listSortPhone.add(lst.sublist(
          i, i + sizeList > lst.length ? lst.length : i + sizeList));
    }
  }
}

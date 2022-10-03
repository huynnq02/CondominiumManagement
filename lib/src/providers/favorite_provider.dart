import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/repository/favorite/delete_favorite/delete_favorite_provider.dart';
import 'package:untitled/src/models/favorite.dart';

import '../../repository/favorite/get_favorite/favorite_provider.dart';
import '../../repository/favorite/post_favorite/post_favorite_provider.dart';
import '../../repository/phone/get_phone_by_id.dart/phone_by_id_provider.dart';
import '../models/phone.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Favorite> listFav = [];
  List<Phone> listPhoneFav = [];
  List<String> listId = [];
  String message = 'Đang cập nhật';

  Future insertFav(String idProduct) async {
    Response data = await PostFavProvider().insertFav(idProduct: idProduct);

    data.statusCode == 500
        ? message = 'Đang tải'
        : data.data['result'] == true
            ? message = 'Thêm thành công'
            : message = 'Sản phẩm đã tồn tại';
    notifyListeners();
  }

  Future deletefav(List id) async {
    DeleteFavProvider().deleteFav(idProduct: id);

    for (int i = 0; i < id.length; i++) {
      listPhoneFav.removeWhere((element) => element.id == id[i]);
    }

    // return listPhoneFav;
  }

  Future getFav() async {
    listFav = await GetFavProvider().getFav();
    List<Phone> listFake = [];
    Phone phone;
    for (int i = 0; i < listFav.length; i++) {
      phone = await PhoneByIdProvider().get(listFav[i].idPhone.toString());
      listFake.add(phone);
    }
    listPhoneFav = [...listFake];

    notifyListeners();
    return listPhoneFav;
  }

  List<Phone> listSearchPhoneFav = [];
  searchPhoneFav({String? text, List<Phone>? listPhone}) {
    listSearchPhoneFav = listPhone!
        .where((element) =>
            element.name!.toUpperCase().contains(text!.toUpperCase()))
        .toList();

    notifyListeners();
  }

  void changeSelected(Phone e) {
    listPhoneFav.where((element) => element.id == e.id).first.selected =
        !listPhoneFav.where((element) => element.id == e.id).first.selected;
    notifyListeners();
  }
}

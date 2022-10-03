import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/models/phone.dart';

import '../models/Filter.dart';

class FilterProvider extends ChangeNotifier {
  bool isShow = false;
  OverlayEntry? overlayEntry;
  List<String> label = [];
  List<Phone> listPhoneFiltered = [];
  List<Phone> listPhone = [];
  FilterModel filter = FilterModel();
  final LayerLink _layerLink = LayerLink();
  void turnOff() {
    isShow = !isShow;
    notifyListeners();
  }

  List<String> filters = [
    'SCREEN',
    'CAMERA',
    'FEATURES',
    'BATTERY',
    'DESIGN',
    'STORAGE',
    'PRICE',
    'PERFORMANCE'
  ];
// lưu thông tin cần lọc
  void saveChangeStateFilter(int index) {
    switch (index) {
      case 0:
        filter.changeScreenState();
        print('Screen :' + filter.screen.toString());
        break;
      case 1:
        filter.changeCameraState();
        print('camera :' + filter.camera.toString());
        break;
      case 2:
        filter.changeFeatureState();
        print('feature :' + filter.feature.toString());
        break;
      case 3:
        filter.changeBatteryState();
        print('battery :' + filter.battery.toString());
        break;
      case 4:
        filter.changeDesignState();
        print('design :' + filter.design.toString());
        break;
      case 5:
        filter.changeStorageState();
        print('storage :' + filter.storage.toString());
        break;
      case 6:
        filter.changePriceState();
        print('price :' + filter.price.toString());
        break;
      case 7:
        filter.changePerformanceState();
        print('performance: ' + filter.performance.toString());
        break;
    }
    notifyListeners();
  }

  // trả về các trạng thái của tính năng cần lọc nếu đã chọn là true ngược lại false
  bool returnFilterType(int index) {
    print(index);
    switch (index) {
      case 0:
        return filter.screen;
      case 1:
        return filter.camera;
      case 2:
        return filter.feature;
      case 3:
        return filter.battery;
      case 4:
        return filter.design;
      case 5:
        return filter.storage;
      case 6:
        return filter.price;
      case 7:
        return filter.performance;
      default:
        return false;
    }
  }

  //tao list filter de apply
  List<Phone> filterToString(List<Phone> list, BuildContext context) {
    List<Phone> listPhoneFiltered1 = [];
    // thực hiện lọc danh sách theo điểm của tính năng
    if (filter.screen) {
      var list1 = list
          .where((element) => element.statistical!.aspectsScore!.sCREEN! > 6);
      listPhoneFiltered1.addAll(list1);
    }

    if (filter.camera) {
      var list1 = list
          .where((element) => element.statistical!.aspectsScore!.cAMERA! > 6);
      listPhoneFiltered1.addAll(list1);
    }

    if (filter.feature) {
      var list1 = list
          .where((element) => element.statistical!.aspectsScore!.fEATURES! > 6);
      listPhoneFiltered1.addAll(list1);
    }
    if (filter.battery) {
      var list1 = list
          .where((element) => element.statistical!.aspectsScore!.bATTERY! > 6);
      listPhoneFiltered1.addAll(list1);
    }

    if (filter.design) {
      var list1 = list
          .where((element) => element.statistical!.aspectsScore!.dESIGN! > 6);
      listPhoneFiltered1.addAll(list1);
    }

    if (filter.storage) {
      var list1 = list
          .where((element) => element.statistical!.aspectsScore!.sTORAGE! > 6);
      listPhoneFiltered1.addAll(list1);
    }

    if (filter.price) {
      var list1 = list
          .where((element) => element.statistical!.aspectsScore!.pRICE! > 6);
      listPhoneFiltered1.addAll(list1);
    }

    if (filter.performance) {
      var list1 = list.where(
          (element) => element.statistical!.aspectsScore!.pERFORMANCE! > 6);
      listPhoneFiltered1.addAll(list1);
    }
    listPhoneFiltered = listPhoneFiltered1.toSet().toList();
    listPhoneFiltered.isEmpty
        ? ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Không có sản phẩm cần lọc')))
        : null;

    return listPhoneFiltered;
  }

  List<Phone> filterPhone(List<Phone>? list) {
    //Kiểm tra danh sách lọc nếu là rỗng thì hiển thị toàn bộ danh sách
    listPhoneFiltered.isEmpty
        ? listPhone = list!
        : listPhone = listPhoneFiltered;

    return listPhone;
  }

  //applyFilter
  Future applyFilter(List<Phone> list, BuildContext context) async {
    filterToString(list, context);

    notifyListeners();
  }

  void removeListCommentFiltered() {
    listPhoneFiltered = [];
  }
}

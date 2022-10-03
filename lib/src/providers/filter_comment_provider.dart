import 'package:flutter/cupertino.dart';
import 'package:untitled/repository/review/review_provider.dart';
import 'package:untitled/src/models/Filter.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import '../models/review.dart';

class FilterCommentProvider extends ChangeNotifier {
  bool isShow = false;

  OverlayEntry? overlayEntry;

  late final RepositoryProvider repositoryProvider;

  List<Review> listCommentFiltered = [];
  List<Review> listComment = [];
  final LayerLink _layerLink = LayerLink();

  FilterModel filter = FilterModel();

  List<String> label = [];

  List<String> rate = ['Positive', 'Neutral', 'Negative'];
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

  bool returnFilterType(int index) {
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

  void turnOff() {
    isShow = !isShow;

    notifyListeners();
  }

  //tao cac filter vd:Screen#Positive
  void generateString() {
    filters.forEach((element) {
      label.add(element); // + '#' + rate[0]
    });
  }

  //tao list filter de apply
  List<String> filterToString() {
    generateString();
    List<String> result = [];
    if (filter.screen) result.add(label[0]);
    if (filter.camera) result.add(label[1]);
    if (filter.feature) result.add(label[2]);
    if (filter.battery) result.add(label[3]);
    if (filter.design) result.add(label[4]);
    if (filter.storage) result.add(label[5]);
    if (filter.price) result.add(label[6]);
    if (filter.performance) result.add(label[7]);

    return result;
  }

  List<Review> filterComment(List<Review>? list) {
    listCommentFiltered.isEmpty
        ? listComment = list!
        : listComment = listCommentFiltered;

    return listComment;
  }

  //applyFilter
  Future applyFilter(String idProduct) async {
    var result = filterToString();
    listCommentFiltered = await ReviewPro().get(result, idProduct);
    notifyListeners();
  }

  void removeListCommentFiltered() {
    listCommentFiltered = [];
  }
}

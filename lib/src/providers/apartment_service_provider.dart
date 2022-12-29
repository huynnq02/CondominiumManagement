import 'package:flutter/material.dart';
import 'package:untitled/repository/service/serviceAPI_provider.dart';
import 'package:untitled/src/models/apartment_service.dart';

class ApartmentServiceProvider extends ChangeNotifier {
  List<ApartmentService> _services = [];

  List<ApartmentService> get services => _services;

  void setListServices(List<ApartmentService> services) {
    _services = services;
    notifyListeners();
  }
}

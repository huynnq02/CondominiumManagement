import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:untitled/src/models/user_service.dart';

class UserServiceProvider extends ChangeNotifier {
  List<UserService> _services = [];

  List<UserService> get services => _services;

  void setListServices(List<UserService> services) {
    _services = services;
    notifyListeners();
  }

  void addService(UserService service) {
    _services.add(service);
    notifyListeners();
  }

  void cancelService(int index) {
    _services.removeAt(index);

    notifyListeners();
  }
}

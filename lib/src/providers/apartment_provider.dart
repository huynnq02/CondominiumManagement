import 'package:flutter/material.dart';
import 'package:untitled/src/models/apartment.dart';
import '../../repository/apartment/apartmentAPI_provider.dart';

class ApartmentProvider extends ChangeNotifier {
  final List<Apartment> _apartmentList = [];
  List<Apartment> get apartmentList => _apartmentList;
  set apartmentList(List<Apartment> value) {
    _apartmentList.clear();
    _apartmentList.addAll(value);
    notifyListeners();
  }

  ApartmentAPIProvider apartmentAPIProvider = ApartmentAPIProvider();
  Future getAllApartments() async {
    var data = await apartmentAPIProvider.getAllApartments();
    List<Apartment> apartments =
        data.map<Apartment>((json) => Apartment.fromMap(json)).toList();
    apartmentList = apartments;
  }
}
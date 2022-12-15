import 'dart:convert';

import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/service/serviceAPI_repository.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/models/user_service.dart';

class ServicePro extends BaseProvider<ServiceRepository> {
  @override
  ServiceRepository initRepository() {
    return ServiceRepository();
  }

  Future<List<ApartmentService>> getApartmentServices() async {
    final res = await repository.getApartmentServices();
    String resBody = res.toString();
    var jsonData = jsonDecode(resBody);
    print(Map<String, dynamic>.from(jsonData['result'])['items']);
    return (Map<String, dynamic>.from(jsonData['result'])['items'] as List)
        .map((e) => ApartmentService.fromMap(e))
        .toList();
  }

  Future<List<UserService>> getUserServices() async {
    final res = await repository.getUsingServices();
    String resBody = res.toString();
    var jsonData = jsonDecode(resBody);
    print(Map<String, dynamic>.from(jsonData['result'])['items']);
    return (Map<String, dynamic>.from(jsonData['result'])['items'] as List)
        .map((e) => UserService.fromMap(e))
        .toList();
  }

  Future<bool> registerService(UserService service) async {
    final res = await repository.registerService(service);
    String resBody = res.toString();
    var jsonData = jsonDecode(resBody);
    return jsonData['success'];
  }

  Future<bool> registerServiceV2(UserService service) async {
    final res = await repository.registerServiceV2(service);
    String resBody = res.toString();
    var jsonData = jsonDecode(resBody);
    return jsonData['success'];
  }

  Future<bool> cancelService(UserService service) async {
    final res = await repository.cancelService(service);
    String resBody = res.toString();
    var jsonData = jsonDecode(resBody);
    print('cancel service: $jsonData');
    return jsonData['success'];
  }

  Future<int> getNumBill() async {
    final res = await repository.getNumBill();
    String resBody = res.toString();
    var jsonData = jsonDecode(resBody);
    return jsonData['result'];
  }
}

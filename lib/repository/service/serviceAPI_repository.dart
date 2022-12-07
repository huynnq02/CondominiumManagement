import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';
import 'package:untitled/src/models/user_service.dart';

class ServiceRepository extends BaseRepository {
  Future<Response> getApartmentServices() async {
    try {
      var client = init();
      final response = await client.get(
        '/api/services/app/ApartmentService/GetApartmentService',
      );

      return response;
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<Response> getUsingServices() async {
    try {
      var client = init();
      final response = await client.get(
        '/api/services/app/UserServiceRegister/GetServiceRegistered',
      );

      return response;
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<Response> registerService(UserService service) async {
    try {
      var client = init();
      final response = await client.post(
        '/api/services/app/UserServiceRegister/RegisterService',
        data: service.toJson(),
      );

      return response;
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }
}

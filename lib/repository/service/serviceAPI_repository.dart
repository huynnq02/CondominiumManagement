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
      print('RegisterService: $response');

      return response;
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<Response> registerServiceV2(UserService service) async {
    try {
      var client = init();
      final response = await client.post(
        '/api/services/app/Bill/CreateServiceBill',
        data: service.toJson(),
      );
      print('create in service register: $response');
      return response;
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<Response> cancelService(UserService service) async {
    print('id: ${service.id}');
    try {
      var client = init();
      final response = await client.post(
        '/api/services/app/UserServiceRegister/UnregisterService',
        queryParameters: {
          "id": service.id,
        },
      );
      print('url: ${response.realUri.path}');
      print('url: ${response.realUri.data}');
      print('url: ${response.requestOptions.data}');

      return response;
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<Response> getNumBill() async {
    try {
      var client = init();
      final response = await client.get(
        '/api/services/app/Bill/GetNumberOfServiceBillToday',
      );
      print(response);
      return response;
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }
}

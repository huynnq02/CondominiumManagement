import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class BillAPIRepository extends BaseRepository {
  Future<Response> getBill() async {
    try {
      var client = init();

      final apartmentsResponse =
          await client.get('/api/services/app/Bill/CreateServiceBill');

      return apartmentsResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getAllAparmentBilllAPIRepository() async {
    try {
      var client = init();

      final authRespone = await client.get(
        '/api/services/app/Bill/GetCurrentUserApartmentBill',
      );
      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getAllServiceBillAPIRepository() async {
    try {
      var client = init();

      final authRespone = await client.get(
        '/api/services/app/Bill/GetCurrentUserServiceBill',
      );
      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getTotalUnpaid() async {
    try {
      var client = init();

      final authRespone = await client.get(
        '/api/services/app/Bill/GetTotalUnpaid',
      );
      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}

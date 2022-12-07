import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class BillAPIRepository extends BaseRepository {
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
}

import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class BillRepository extends BaseRepository {
  Future<Response> getAllEAndWBillAPIRepository() async {
    try {
      var client = init();

      final authRespone = await client.get(
        '/api/services/app/Bill/GetAllEAndWBill',
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
        '/api/services/app/Bill/GetAllServiceBill',
      );
      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}

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
}

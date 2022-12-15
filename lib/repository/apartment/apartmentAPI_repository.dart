import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class ApartmentAPIRepository extends BaseRepository {
  Future<Response> getAllApartments() async {
    try {
      var client = init();

      final apartmentsResponse = await client.get(
        '/api/services/app/Apartment/GetAllApartments'
      );

      return apartmentsResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}
import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class PhoneByIdRepository extends BaseRepository {
  Future<Response> phones(String idProduct) async {
    try {
      var client = init();
      final phones = await client.get(
          '/api/services/app/Product/GetProductById',
          queryParameters: {"id": idProduct});
      //http://aireviewapi.gamscloud.vn/api/Phone
      return phones;
    } on DioError catch (error) {
      print(error);
      rethrow;
      // if (error.response == null) {
      //   print("respone is null");
      //   print(error);
      //   print(
      //       '----------------------------------');
      // }
      // throw error.response as Response;
    }
  }
}

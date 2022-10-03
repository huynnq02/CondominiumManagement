import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class PhoneRepository extends BaseRepository {
  Future<Response> phones() async {
    try {
      var client = init();
      final phones =
          await client.get('/api/services/app/Product/GetAllProduct');
      //http://aireviewapi.gamscloud.vn/api/Phone
      return phones;
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }
}

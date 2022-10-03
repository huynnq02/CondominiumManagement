import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class ReviewRepository extends BaseRepository {
  Future<Response> review(List listLabel, String idProduct) async {
    try {
      var client = init();
      final review = await client
          .post('/api/services/app/Product/FilterComment', queryParameters: {
        'productId': idProduct,
        'listFilter': listLabel.toString()
      });

      return review;
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

import '../../../utils/helper/app_preference.dart';

class DeleteFavoriteReponsitory extends BaseRepository {
  Future<Response> deleteFavorite(List idProduct) async {
    try {
      var client = init();
      String uid = AppPreferences.prefs.getString('userId').toString();

      final insert = await client.delete(
          '/api/services/app/Product/DeleteListFavoriteProduct',
          queryParameters: {
            'listProductId': idProduct.toString(),
            'userId': uid
          });
      return insert;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}

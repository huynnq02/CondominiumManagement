import 'dart:io';

import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class FavoriteReponsitory extends BaseRepository {
  Future<Response> getFavorite() async {
    try {
      var client = init();

      final favorite = await client.get(
        '/api/services/app/Product/GetFavoriteProductByUserId',
      );

      return favorite;
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

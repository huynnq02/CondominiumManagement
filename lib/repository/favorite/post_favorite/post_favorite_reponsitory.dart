import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';

class PostFavoriteReponsitory extends BaseRepository {
  Future<Response> postFavorite(String idProduct) async {
    try {
      var client = init();
      final insert = await client.post(
          '/api/services/app/Product/AddFavoriteProduct',
          queryParameters: {'productId': idProduct});

      return insert;
    } on DioError catch (error) {
      print(error);
      return error.response as Response;
    }
  }
}

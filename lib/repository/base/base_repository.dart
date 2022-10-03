import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/utils/helper/app_preference.dart';

abstract class BaseRepository {
  static String get tokenAuth => AppPreferences.prefs.getString('token') ?? '';
  var baseUrl =
      'https://aireviewapi.azurewebsites.net'; //'https://10.0.2.2:44301';
  @protected
  Dio init() {
    Dio dio = Dio();

    dio.options.baseUrl = baseUrl;

    dio.options.responseType = ResponseType.json;
    if (tokenAuth.isNotEmpty) {
      dio.options.headers = {
        'Authorization': 'Bearer $tokenAuth',
      };
    }

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }

  BaseRepository();
}

class AppConstant {}

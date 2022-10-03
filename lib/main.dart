import 'package:flutter/material.dart';
import 'package:untitled/app.dart';
import 'package:untitled/utils/helper/app_preference.dart';

void main() async {
  print('=========== APP RUN =========');
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.init();
  runApp(const App());
}

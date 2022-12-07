import 'package:flutter/material.dart';
import 'package:untitled/app.dart';
import 'package:untitled/utils/helper/app_preference.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  print('=========== APP RUN =========');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await AppPreferences.init();
  runApp(App());
}

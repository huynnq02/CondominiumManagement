import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/src/providers/auth_provider.dart';
import 'package:untitled/src/providers/compare_provider.dart';
import 'package:untitled/src/providers/data_multi_chart.dart';
import 'package:untitled/src/providers/favorite_provider.dart';
import 'package:untitled/src/providers/filter_provider.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/providers/register_provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/providers/repository_provider.dart';

import 'package:untitled/src/screens/main%20screen/main_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    removeToken();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return FilterProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return RepositoryProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return AuthenticationProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return LoginProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return FavoriteProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return DataMultiChartProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return CompareProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return ProfileProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return RegisterProvider();
            },
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              body: MainScreen(
            checkScreen: false,
          )),
        ));
  }
}

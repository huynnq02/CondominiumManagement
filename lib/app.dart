import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/src/providers/apartment_service_provider.dart';
import 'package:untitled/src/providers/auth_provider.dart';
import 'package:untitled/src/providers/bill_provider.dart';
import 'package:untitled/src/providers/compare_provider.dart';
import 'package:untitled/src/providers/data_multi_chart.dart';
import 'package:untitled/src/providers/feedback_provider.dart';
import 'package:untitled/src/providers/filter_provider.dart';
import 'package:untitled/src/providers/otp_provider.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/providers/register_provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import 'package:untitled/src/providers/reset_password_provider.dart';
import 'package:untitled/src/providers/user_service_provider.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';
import 'package:untitled/src/screens/main%20screen/main_screen.dart';
import 'package:untitled/utils/helper/app_preference.dart';

import 'src/providers/apartment_provider.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLoggedIn = false;

  Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('token');
  }

  Future navigateUser(BuildContext context) async {
    var token = AppPreferences.prefs.getString('token');
    if (token != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    navigateUser(context);
  }

  @override
  Widget build(BuildContext context) {
    // removeToken();
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
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return OTPProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return ResetPasswordProvider();
            },
          ),
          ChangeNotifierProvider(create: (BuildContext context) {
            return FeedbackProvider();
          }),
          ChangeNotifierProvider(create: (BuildContext context) {
            return BillProvider();
          }),
          ChangeNotifierProvider(create: (BuildContext context) {
            return ApartmentProvider();
          }),
          ChangeNotifierProvider(create: (BuildContext context) {
            return UserServiceProvider();
          }),
          ChangeNotifierProvider(create: (BuildContext context) {
            return ApartmentServiceProvider();
          })
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Lato'),
          home: isLoggedIn
              ? MainScreen(
                  checkScreen: true,
                )
              : const LoginScreen(),
        ));
  }
}

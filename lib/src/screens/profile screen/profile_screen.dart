import "package:flutter/material.dart";
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled/src/screens/profile%20screen/widget/profile_picture.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Huy Nguyen";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login-screen-background.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

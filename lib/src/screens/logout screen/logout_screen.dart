import 'package:flutter/material.dart';
import 'package:untitled/src/screens/logout%20screen/logout_confirm_dialog.dart';
import '../../../utils/app_constant/app_colors.dart';

class LogoutTemp extends StatefulWidget {
  const LogoutTemp({Key? key}) : super(key: key);

  @override
  State<LogoutTemp> createState() => _LogoutTempState();
}

class _LogoutTempState extends State<LogoutTemp> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.White,
      child: Center(
        child: ElevatedButton(
          onPressed: () => showLogoutConfirmPopupDialog(context, height, width),
          child: const Text("Show confirm logout popup"),
        ),
      ),
    );
  }

  void showLogoutConfirmPopupDialog(BuildContext context, height, width) =>
      showDialog(
          context: context, builder: ((context) => LogOutConfirmDialog()));
}

import "package:flutter/material.dart";
import 'package:untitled/utils/app_constant/app_colors.dart';

class LoginErrorDialog extends StatefulWidget {
  const LoginErrorDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginErrorDialog> createState() => _LoginErrorDialogState();
}

class _LoginErrorDialogState extends State<LoginErrorDialog> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        height: height * 0.4,
        width: width * 0.8,
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.Black, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 17, left: 8, right: 8),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.015,
                ),
                SizedBox(
                  width: width * 0.6,
                  child: const Text(
                    "Email hoặc mật khẩu không hợp lệ!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.023,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width * 0.4, height * 0.05),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                  },
                  child: const Text(
                    "Đóng",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: height * 0.023,
                ),
                Image.asset("assets/apata-logo-error.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

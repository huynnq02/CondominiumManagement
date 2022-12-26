import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class UpdatePasswordDialog extends StatefulWidget {
  const UpdatePasswordDialog({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordDialog> createState() => _UpdatePasswordDialogState();
}

class _UpdatePasswordDialogState extends State<UpdatePasswordDialog> {
  int sec = 3;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    timer = Timer.periodic(
      duration,
      (timer) {
        if (sec == 0) {
          navigate();
          return;
        }
        setState(() {
          sec--;
        });
      },
    );
  }

  void navigate() {
    timer.cancel();
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: Colors.white),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Đổi mật khẩu thành công !',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.DarkPink,
                    fontSize: 20),
              ),
              const SizedBox(height: 21),
              Text('Bạn sẽ được quay trở về màn hình đăng nhập trong $sec(s)',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF625E5E),
                      fontSize: 12),
                  textAlign: TextAlign.center),
              const SizedBox(height: 21),
              OutlinedButton(
                onPressed: navigate,
                child: const Text(
                  "ĐÓNG",
                  style: TextStyle(
                      color: Color(0xFF625E5E),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD9D9D9)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 52),
                ),
              ),
            ]),
      ),
    );
  }
}

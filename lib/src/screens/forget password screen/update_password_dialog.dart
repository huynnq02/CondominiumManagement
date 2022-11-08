import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';

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
        padding: const EdgeInsets.only(top: 22, bottom: 18),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            image: DecorationImage(
              image: AssetImage("assets/logout-confirm-dialog-background.png"),
              fit: BoxFit.cover,
            )),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Đổi mật khẩu thành công !',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A67E8),
                    fontSize: 20),
              ),
              const SizedBox(height: 21),
              Text('Bạn sẽ được quay trở về màn hình đăng nhập sau $sec(s)',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12)),
              const SizedBox(height: 21),
              OutlinedButton(
                onPressed: navigate,
                child: const Text(
                  "Đóng",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFEAE6F4),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: Size.zero,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 33, vertical: 3),
                    shadowColor: Colors.black,
                    elevation: 4),
              ),
            ]),
      ),
    );
  }
}

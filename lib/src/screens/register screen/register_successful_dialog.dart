import 'package:flutter/material.dart';

import '../login screen/login_screen.dart';

class RegisterSuccessfulDialog extends StatelessWidget {
  const RegisterSuccessfulDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22),
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
                'Bạn đã đăng ký thành công!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 26, 6, 255),
                    fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text('Vui lòng đợi để được xét duyệt!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 26, 6, 255),
                      fontSize: 16)),
              const SizedBox(height: 28),
              OutlinedButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => LoginScreen())));
                }),
                child: const Text(
                  "Đồng ý",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFEAE6F4),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 33),
                    shadowColor: Colors.black,
                    elevation: 4),
              ),
            ]),
      ),
    );
  }
}

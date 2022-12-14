import 'package:flutter/material.dart';
import '../login screen/login_screen.dart';

class RegisterSuccessfulDialog extends StatelessWidget {
  const RegisterSuccessfulDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: width*0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black)
      ),
      child: Container(
        padding: EdgeInsets.only(top: 22,bottom: 18,left: width*0.04,right: width*0.04),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          // image: DecorationImage(
          //   image: AssetImage("assets/logout-confirm-dialog-background.png"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Đăng ký thành công!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57D00),
                    fontSize: 20),
              ),
              const SizedBox(height: 14),
              const Text(
                'Tài khoản của bạn sẽ được duyệt và hãy đợi thông báo được gửi qua số điện thoại/ email mà bạn đã đăng ký nhé!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 12),
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => const LoginScreen())));
                }),
                child: const Text(
                  "Đóng",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 33),
                    shadowColor: Colors.black.withOpacity(0.25),
                    elevation: 4),
              ),
            ]),
      ),
    );
  }
}
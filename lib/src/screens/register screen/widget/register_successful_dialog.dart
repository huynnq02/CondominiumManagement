import 'package:flutter/material.dart';
import '../../login screen/login_screen.dart';

class RegisterSuccessfulDialog extends StatelessWidget {
  const RegisterSuccessfulDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: width * 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: EdgeInsets.only(
            top: 22, bottom: 18, left: width * 0.04, right: width * 0.04),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          // image: DecorationImage(
          //   image: AssetImage("assets/logout-confirm-dialog-background.png"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(
            'Đăng ký thành công!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFD0255E),
                fontSize: 20),
          ),
          const SizedBox(height: 14),
          const Text(
              'Tài khoản của bạn đang được xét duyệt.\nChúng tôi sẽ cập nhật trạng thái tài khoản\nqua số điện thoại hoặc email.',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF625E5E),
                  fontSize: 12),
              textAlign: TextAlign.center),
          const SizedBox(height: 14),
          OutlinedButton(
            onPressed: (() {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const LoginScreen())));
            }),
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

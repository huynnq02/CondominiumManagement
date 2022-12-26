import 'package:flutter/material.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/screens/change%20email%20screen/change_email_screen.dart';
import 'package:untitled/src/screens/change%20phone%20number%20screen/change_phone_number_screen.dart';
import 'package:untitled/src/screens/forget%20password%20screen/update_new_password_screen.dart';
import 'package:untitled/src/screens/security%20screen/widgets/security_option.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class SecurityScreen extends StatefulWidget {
  MDUser? mdUser;

  SecurityScreen({this.mdUser, Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.AppBackground,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bảo mật'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.RedTheme,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => ChangeEmailScreen(
                          mdUser: widget.mdUser,
                        ))));
              },
              child: const SecurityOption(
                title: "Cập nhật địa chỉ email",
                leadingIcon: "email-icon",
                topRadius: 8,
                shadow: 0,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => ChangePhoneNumberScreen(
                          mdUser: widget.mdUser,
                        ))));
              },
              child: const SecurityOption(
                title: "Cập nhật số điện thoại",
                leadingIcon: "phone-icon",
                shadow: 0,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const UpdateNewPasswordScreen(
                          isLoggedIn: true,
                        ))));
              },
              child: const SecurityOption(
                title: "Cập nhật mật khẩu",
                leadingIcon: "key-icon",
                bottomRadius: 8,
                shadow: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

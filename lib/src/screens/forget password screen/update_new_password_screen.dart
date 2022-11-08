import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/src/screens/forget%20password%20screen/update_password_dialog.dart';
import 'package:untitled/src/screens/register%20screen/widget/widget_button.dart';
import 'package:untitled/src/widget/outlined_text.dart';
import 'package:untitled/src/widget/register_textfield.dart';
import 'package:untitled/utils/app_constant/app_shadows.dart';

class UpdateNewPasswordScreen extends StatefulWidget {
  const UpdateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdateNewPasswordScreen> createState() =>
      _UpdateNewPasswordScreenState();
}

class _UpdateNewPasswordScreenState extends State<UpdateNewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/register_bg.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter),
      ),
      child: SafeArea(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 58),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedText(
                  text: 'Đổi mật khẩu',
                  style: GoogleFonts.tomorrow(),
                  fontSize: 32,
                  strokeColor: Colors.black,
                  isShadowed: true,
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  width: 248,
                  margin: const EdgeInsets.only(left: 13),
                  child: Text(
                    'Mật khẩu mới của bạn phải khác so với mật khẩu cũ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        shadows: AppShadows.defaultShadows),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nhập mật khẩu mới',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            shadows: AppShadows.defaultShadows),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Form(
                        key: _formKey,
                        child: RegisterTextField(
                          labelText: 'Mật khẩu',
                          border: BorderRadius.circular(12),
                          type: TextFieldType.password,
                          maxLength: 20,
                        ),
                      )
                    ],
                  ),
                )),
                const SizedBox(
                  height: 26,
                ),
                WidgetButton(
                  labelText: 'Đổi mật khẩu',
                  width: 185,
                  onPressed: () {
                    setState(() {});
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const UpdatePasswordDialog();
                          });
                    }
                  },
                )
              ],
            ),
          ),
          IconButton(
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(22),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset('assets/back.svg'))
        ]),
      ),
    ));
  }
}

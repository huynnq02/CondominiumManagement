import 'package:flutter/material.dart';
import 'package:untitled/src/models/user.dart';
import 'package:iconsax/iconsax.dart' as ic;
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class ChangeEmailScreen extends StatefulWidget {
  MDUser? mdUser;
  ChangeEmailScreen({Key? key, this.mdUser}) : super(key: key);

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isValidEmail = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFCF6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB2F68),
        title: const Text("Cập nhật địa chỉ email"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Center(
                  child: Image.asset(
                    "assets/sms-tracking-icon.png",
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  "Cập nhật địa chỉ email",
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF58583A),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCF6F6),
                    // .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isValidEmail == true
                          ? const Color(0xFFD9D9D9)
                          : Colors.red,
                      width: 1,
                    ),
                  ),
                  child: Form(
                    key: _emailFormKey,
                    child: TextFormField(
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                      onChanged: (value) => {},
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        errorStyle: TextStyle(height: 0),
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
                if (!_isValidEmail)
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Địa chỉ email không hợp lệ",
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.Red,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  decoration: BoxDecoration(
                    color: AppColors.RedTheme,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.02,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (!_emailController.text.isValidEmail()) {
                          setState(() {
                            _isValidEmail = false;
                          });
                        }
                      },
                      splashColor: Colors.grey,
                      child: Center(
                        child: Text(
                          "Tiếp tục",
                          style: AppTextStyle.lato.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/reset_password_provider.dart';
import 'package:untitled/src/screens/forget%20password%20screen/widgets/change_password_input.dart';
import 'package:untitled/src/screens/login%20screen/widget/custom_button.dart';
import 'package:untitled/src/widget/outlined_text.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class UpdateNewPasswordScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String? email;
  const UpdateNewPasswordScreen(
      {Key? key, required this.isLoggedIn, this.email})
      : super(key: key);

  @override
  State<UpdateNewPasswordScreen> createState() =>
      _UpdateNewPasswordScreenState();
}

class _UpdateNewPasswordScreenState extends State<UpdateNewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ResetPasswordProvider? provider;
  TextEditingController currentPwController = TextEditingController();
  TextEditingController newPwController = TextEditingController();
  TextEditingController confirmPwController = TextEditingController();
  String confirmErr = '';

  @override
  void initState() {
    provider = Provider.of<ResetPasswordProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    provider!.resetPwError();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ResetPasswordProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.DarkPink,
          toolbarHeight: 60,
          title: const Text(
            'Đổi mật khẩu',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFFFCF6F6)),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                'assets/back.svg',
                height: 24,
              )),
        ),
        backgroundColor: AppColors.White,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: width*0.09, vertical: height*0.056),
          child: Column(
            children: [
              SvgPicture.asset('assets/change-pw-decoration.svg'),
              SizedBox(
                height: height*0.027,
              ),
              Text(
                widget.isLoggedIn
                    ? 'Nhập lại mật khẩu cũ để xác nhận'
                    : 'Tạo một mật khẩu mới cho bạn',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF58583A)),
              ),
              SizedBox(
                height: height*0.06,
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (widget.isLoggedIn)
                        Column(
                          children: [
                            ChangePasswordInput(
                              pwController: currentPwController,
                              label: 'Nhập mật khẩu hiện tại của bạn',
                              labelText: 'Mật khẩu hiện tại',
                              error: data.pwError,
                              pwRule: false,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                          ],
                        ),
                      ChangePasswordInput(
                        pwController: newPwController,
                        label: 'Nhập mật khẩu mới mà bạn muốn',
                        labelText: 'Mật khẩu mới',
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      ChangePasswordInput(
                        pwController: confirmPwController,
                        label: 'Nhập lại mật khẩu mới',
                        labelText: 'Nhập lại mật khẩu mới',
                        error: confirmErr,
                        pwRule: false,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                  onPressed: () {
                    setState(() {
                      data.pwError = '';
                    });
                    if (_formKey.currentState!.validate()) {
                      if (newPwController.text == confirmPwController.text) {
                        setState(() {
                          confirmErr = '';
                        });
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        if (!widget.isLoggedIn) {
                          provider!.resetPassword(
                              widget.email!, newPwController.text, context);
                        } else {
                          provider!.changePassword(currentPwController.text,
                              newPwController.text, context);
                        }
                      } else {
                        setState(() {
                          confirmErr = 'Mật khẩu không khớp';
                        });
                      }
                    }
                  },
                  label: 'Hoàn thành')
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/reset_password_provider.dart';
import 'package:untitled/src/screens/forget%20password%20screen/widgets/change_password_input.dart';
import 'package:untitled/src/screens/register%20screen/widget/widget_button.dart';
import 'package:untitled/src/widget/outlined_text.dart';

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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/register_light_bg.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter),
          ),
          child: SafeArea(
            child: Stack(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 38, vertical: 60),
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
                      height: 56,
                    ),
                    Expanded(
                        child: SizedBox(
                      width: double.infinity,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                      height: 18,
                                    ),
                                  ],
                                ),
                              ChangePasswordInput(
                                pwController: newPwController,
                                label: 'Nhập mật khẩu mới mà bạn muốn',
                                labelText: 'Mật khẩu mới',
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              ChangePasswordInput(
                                pwController: confirmPwController,
                                label: 'Nhập lại mật khẩu mới',
                                labelText: 'Xác nhận mật khẩu',
                                error: confirmErr,
                                pwRule: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(
                      height: 26,
                    ),
                    WidgetButton(
                      labelText: 'Đổi mật khẩu',
                      width: 185,
                      onPressed: () {
                        setState(() {
                          data.pwError = '';
                        });
                        if (_formKey.currentState!.validate()) {
                          if (newPwController.text ==
                              confirmPwController.text) {
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

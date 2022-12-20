import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/reset_password_provider.dart';
import 'package:untitled/src/screens/forget%20password%20screen/widgets/change_password_input.dart';
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:
            widget.isLoggedIn ? AppColors.LightPurple : AppColors.White,
        body: SafeArea(
          child: Stack(children: [
            Column(
              children: [
                Padding(
                  padding: widget.isLoggedIn
                      ? const EdgeInsets.symmetric(vertical: 62)
                      : EdgeInsets.only(top: height*0.11,bottom: height*0.04),
                  child: OutlinedText(
                    text: 'Đổi mật khẩu',
                    fontSize: 48,
                    isShadowed: true,
                    strokeColor:
                        widget.isLoggedIn ? Colors.white : Colors.black,
                    color: widget.isLoggedIn ? Colors.white : Colors.black,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: height * 0.07, left: 38, right: 38),
                    decoration: const BoxDecoration(
                        color: AppColors.White,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      children: [
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
                                      SizedBox(
                                        height: height * 0.05,
                                      ),
                                    ],
                                  ),
                                ChangePasswordInput(
                                  pwController: newPwController,
                                  label: 'Nhập mật khẩu mới mà bạn muốn',
                                  labelText: 'Mật khẩu mới',
                                ),
                                SizedBox(
                                  height: height * 0.05,
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
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.Purple,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    shadowColor: Colors.transparent),
                                child: const Text(
                                  'Đổi mật khẩu',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
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
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          });
                                      if (!widget.isLoggedIn) {
                                        provider!.resetPassword(widget.email!,
                                            newPwController.text, context);
                                      } else {
                                        provider!.changePassword(
                                            currentPwController.text,
                                            newPwController.text,
                                            context);
                                      }
                                    } else {
                                      setState(() {
                                        confirmErr = 'Mật khẩu không khớp';
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(22),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  'assets/back.svg',
                  color: widget.isLoggedIn ? Colors.white : Colors.black,
                ))
          ]),
        ));
  }
}

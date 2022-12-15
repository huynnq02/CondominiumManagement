import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/reset_password_provider.dart';
import 'package:untitled/src/screens/forget%20password%20screen/widgets/change_password_input.dart';
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
        body: SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/change-password-bg.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter),
            ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 108),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Text(
                          'Đổi mật khẩu',
                          style: GoogleFonts.tomorrow(
                              fontSize: 32, color: Colors.white),
                        )),
                    const SizedBox(
                      height: 36,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 32, left: 33, right: 43),
                        decoration: const BoxDecoration(
                            color: AppColors.White,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                          children: [
                            SizedBox(
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
                                              label:
                                                  'Nhập mật khẩu hiện tại của bạn',
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
                            ),
                            Expanded(
                              child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.DarkBlue,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 62),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 4),
                                  child: Text(
                                    'Đổi mật khẩu',
                                    style: GoogleFonts.lexendExa(fontSize: 16),
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
                          ],
                        ),
                      ),
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
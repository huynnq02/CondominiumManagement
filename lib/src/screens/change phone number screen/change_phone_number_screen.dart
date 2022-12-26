import 'dart:async';

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/helper/string_extensions.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  MDUser? mdUser;
  ChangePhoneNumberScreen({Key? key, this.mdUser}) : super(key: key);
  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  SharedPreferences? pref;
  bool _isExpired = true;
  bool? _isValidOTP, _isDone, _isValidPhoneNumber;
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();

  ProfileProvider? profileProvider;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String? otp;
  int min = 0, sec = 60;
  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      _isExpired = false;
      if (min == 0 && sec == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            _isExpired = true;

            min = 0;
            sec = 60;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            if (min > 0 && sec == 0) {
              min--;
              sec = 60;
            }
            //_isWaiting = true;
            sec--;
          });
        }
      }
    });
  }

  getSharedPreferences() async {}

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileProvider>(context);
    // print("is valid otp");
    // print(_isValidOTP);
    // print("is expired otp");

    // print(_isExpired);
    //print('hihi');

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.AppBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.RedTheme,
        elevation: 0,
        title: Text(
          "Cập nhật số điện thoại",
          style: AppTextStyle.lato.copyWith(
            fontSize: 23,
            color: AppColors.White,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.White,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            height: height,
            width: width,
            // decoration: const BoxDecoration(
            //   color: Colors.transparent,
            //   image: DecorationImage(
            //     image: AssetImage("assets/login-screen-background.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Expanded(
                  child: Column(
                    children: [
                      _isDone == true
                          ? const Image(
                              image: AssetImage("assets/big-message-icon.png"),
                            )
                          : const Image(
                              image: AssetImage("assets/big-phone-icon.png"),
                            ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        _isDone == true
                            ? "Xác thực OTP"
                            : "Nhập số điện thoại mới",
                        style: AppTextStyle.lato.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                            color: const Color(0xFF58583A)),
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
                            color: _isValidPhoneNumber == null ||
                                    _isValidPhoneNumber == true
                                ? const Color(0xFFD9D9D9)
                                : Colors.red,
                            width: 1,
                          ),
                        ),
                        child: _isDone == true
                            ? Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Form(
                                  key: _otpFormKey,
                                  child: TextFormField(
                                    controller: otpController,
                                    textAlign: TextAlign.center,
                                    readOnly: _isExpired == true ? true : false,
                                    style: const TextStyle(fontSize: 18),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6)
                                    ],
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.length < 6) {
                                          setState(() {
                                            _isValidOTP = false;
                                          });
                                          return '';
                                        }
                                      }
                                      setState(() {
                                        _isValidOTP = true;
                                      });
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Nhập mã OTP",
                                      border: InputBorder.none,
                                      errorStyle: TextStyle(height: 0),
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Form(
                                  key: _phoneFormKey,
                                  child: TextFormField(
                                    controller: phoneNumberController,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(14)
                                    ],
                                    onChanged: (value) => {
                                      setState(() {
                                        _isValidPhoneNumber =
                                            value.isValidPhoneNumber();
                                      })
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Số điện thoại",
                                      border: InputBorder.none,
                                      errorStyle: TextStyle(height: 0),
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: height * 0.007,
                      ),
                      if (_isValidOTP == false && _isExpired == false ||
                          user.isValidOTPProvider == false &&
                              _isExpired == false)
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Mã OTP không đúng, vui lòng nhập lại",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.Red,
                            ),
                          ),
                        ),
                      if (_isValidPhoneNumber == false)
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Số điện thoại không hợp lệ",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.Red,
                            ),
                          ),
                        ),
                      if (_isDone == true)
                        Column(
                          children: [
                            if (!_isExpired)
                              Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  SizedBox(
                                    width: width * 0.7,
                                    child: Text(
                                      "Vui lòng kiểm tra điện thoại của bạn để nhận mã OTP",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.lato.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF140E09),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                ],
                              ),
                            if (_isExpired)
                              Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      otpController.clear();
                                      _isValidOTP = true;
                                      user.setIsValidOTP(true);
                                      Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .sendOTPToPhoneNumber(
                                              context,
                                              phoneNumberController.text
                                                  .trim());
                                      startTimer();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Chưa nhận được mã OTP? ",
                                        style: AppTextStyle.lato.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF140E09),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Gửi lại",
                                            style: AppTextStyle.lato.copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFFFE2C6B),
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (!_isExpired)
                              RichText(
                                text: TextSpan(
                                  text: "Bạn có thể gửi lại mã OTP sau ",
                                  style: AppTextStyle.lato.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF140E09),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "$min:$sec",
                                      style: AppTextStyle.lato.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFFBEBAB7),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      if (_isValidPhoneNumber == true && _isDone != true)
                        user.isLoading
                            ? const CircularProgressIndicator()
                            : Container(
                                width: width,
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
                                      Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .sendOTPToPhoneNumber(
                                              context,
                                              phoneNumberController.text
                                                  .trim());
                                      print("ok");
                                      setState(() {
                                        _isDone = true;
                                      });
                                      startTimer();
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
                      if (_isDone == true && _isExpired == false)
                        user.isLoading
                            ? const CircularProgressIndicator()
                            : Container(
                                width: width,
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
                                      if (_otpFormKey.currentState!
                                          .validate()) {
                                        Provider.of<ProfileProvider>(context,
                                                listen: false)
                                            .verifyOTP(
                                                context,
                                                otpController.text,
                                                phoneNumberController.text);
                                        print(user.isValidOTPProvider);
                                      }
                                    },
                                    splashColor: Colors.grey,
                                    child: Center(
                                      child: Text(
                                        "Hoàn thành",
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
                      // Padding(
                      //   padding: EdgeInsets.only(left: width * 0.06),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       user.isSent == true &&
                      //               _isWaiting == true &&
                      //               _isValidOTP != true &&
                      //               user.changePhoneFail == true
                      //           ? "OTP không đúng"
                      //           : "",
                      //       style: AppTextStyle.lato.copyWith(
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w500,
                      //         color: AppColors.Red,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     print("zo ne b oi");

                      //     user.setIsSent(false);
                      //     user.setChangePhoneFail(false);

                      //     if (_isWaiting == false) {
                      //       setState(() {
                      //         otpController.text = "";
                      //       });
                      //     }
                      //     if (_isOTPSent == true && _isWaiting == false) {
                      //       setState(() {
                      //         _isValidOTP = null;
                      //       });
                      //     }
                      //     if ((_isWaiting == null || _isWaiting == false)) {
                      //       startTimer();
                      //       profileProvider!.sendOTPToChangePhoneNumber(
                      //           widget.mdUser!, context);
                      //       setState(() {
                      //         _isOTPSent = true;
                      //         _isWaiting = true;
                      //       });
                      //       user.setIsSent(true);
                      //     }
                      //     if (_isDone == true) {
                      //       print(" loading ne: " + user.isLoading.toString());
                      //       profileProvider!.changePhoneNumber(
                      //           context,
                      //           widget.mdUser!,
                      //           phoneNumberController.text,
                      //           otpController.text);
                      //       print(" loading ne: " + user.isLoading.toString());
                      //     }
                      //     print("isSent: " + user.isSent.toString());
                      //     print("changePhoneFail: " +
                      //         user.changePhoneFail.toString());
                      //     print("isValidOTP: " + _isValidOTP.toString());
                      //     print("isDone: " + _isDone.toString());
                      //     print("isWaiting: " + _isWaiting.toString());
                      //   },
                      //   child: Column(
                      //     children: [
                      //       if (_isOTPSent == false)
                      //         ButtonContainer(
                      //           height: height,
                      //           width: width,
                      //           text: "Gửi mã OTP",
                      //           // color: const Color(0xFF5FC5FF),
                      //           color: AppColors.White,
                      //         ),
                      //       if (_isOTPSent == true &&
                      //           _isWaiting == true &&
                      //           user.isSent == true &&
                      //           _isDone == false)
                      //         ButtonContainer(
                      //           height: height,
                      //           width: width,
                      //           text: sec / 10 == 0
                      //               ? "0$min:0$sec"
                      //               : "0$min:$sec",
                      //           // color: const Color(0xFFCDCDCD),
                      //           color: AppColors.White,
                      //         ),
                      //       if (_isOTPSent == true &&
                      //           _isWaiting == false &&
                      //           _isDone == false)
                      //         ButtonContainer(
                      //           height: height,
                      //           width: width,
                      //           text: "Gửi lại OTP",
                      //           // color: const Color(0xFF5FC5FF),
                      //           color: AppColors.White,
                      //         ),
                      //       if (_isDone == true)
                      //         if (_isValidPhoneNumber != null &&
                      //             _isValidPhoneNumber == true)
                      //           user.isLoading
                      //               ? const CircularProgressIndicator()
                      //               : ButtonContainer(
                      //                   height: height,
                      //                   width: width,
                      //                   text: "Hoàn thành",
                      //                   // color: const Color(0xFF5FC5FF),
                      //                   color: AppColors.White,
                      //                 ),
                      //     ],
                      //   ),
                      // ),
                      // if (user.isSent)
                      //   Column(
                      //     children: [
                      //       SizedBox(
                      //         height: height * 0.02,
                      //       ),
                      //       SizedBox(
                      //         width: width * 0.7,
                      //         child: Text(
                      //           user.isSent == true &&
                      //                   _isWaiting == true &&
                      //                   _isDone != true &&
                      //                   _isValidOTP != true &&
                      //                   user.changePhoneFail == false
                      //               ? "Đã gửi OTP, vui lòng check trong hộp thư Email của bạn và điền mã OTP vào ô dưới đây"
                      //               : user.isSent == true &&
                      //                       _isWaiting == false &&
                      //                       _isDone != true
                      //                   ? "OTP đã hết hạn, vui lòng gửi lại OTP"
                      //                   : '',
                      //           style: AppTextStyle.lato.copyWith(
                      //               fontSize: 13, color: AppColors.Red),
                      //           textAlign: TextAlign.center,
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: height * 0.015,
                      //       ),
                      //       if (user.isSent &&
                      //           _isWaiting == true &&
                      //           _isDone == false)
                      //         InkWell(
                      //           onTap: () async {
                      //             user.setIsLoading(true);
                      //             user.setChangePhoneFail(false);
                      //             print(1);
                      //             if (_isWaiting == true &&
                      //                 _isWaiting != null) {
                      //               print(2);

                      //               if (min >= 0 && sec > 0) {
                      //                 print(3);

                      //                 if (_otpFormKey.currentState!
                      //                     .validate()) {
                      //                   print(4);

                      //                   if (_isValidOTP == true) {
                      //                     if (_isValidOTP == true &&
                      //                         _isOTPSent == true) {
                      //                       await profileProvider!.checkOTP(
                      //                         context,
                      //                         otp!,
                      //                         widget.mdUser!,
                      //                       );
                      //                       pref = await SharedPreferences
                      //                           .getInstance();
                      //                       bool tempData =
                      //                           pref!.getBool("isValidOTP")!;
                      //                       if (mounted) {
                      //                         setState(() {
                      //                           _isValidOTP = tempData;
                      //                           _isDone = tempData;
                      //                         });
                      //                       }
                      //                       // user.setChangePhoneFail(!_isDone);
                      //                       if (_isDone == false) {
                      //                         if (mounted) {
                      //                           setState(() {
                      //                             otpController.clear();
                      //                           });
                      //                         }
                      //                       }
                      //                       print("isSent: " +
                      //                           user.isSent.toString());
                      //                       print("changePhoneFail: " +
                      //                           user.changePhoneFail
                      //                               .toString());
                      //                       print("isValidOTP: " +
                      //                           _isValidOTP.toString());
                      //                       print("isDone: " +
                      //                           _isDone.toString());
                      //                       print("isWaiting: " +
                      //                           _isWaiting.toString());
                      //                     }
                      //                   }
                      //                 } else {
                      //                   if (mounted) {
                      //                     setState(() {
                      //                       otpController.clear();
                      //                     });
                      //                   }

                      //                   user.setChangePhoneFail(true);
                      //                 }
                      //                 user.setIsLoading(false);
                      //               }
                      //             }
                      //           },
                      //           child: user.isLoading
                      //               ? const Center(
                      //                   child: CircularProgressIndicator())
                      //               : Container(
                      //                   padding: EdgeInsets.only(
                      //                     top: height * 0.013,
                      //                     bottom: height * .013,
                      //                     left: width * 0.1,
                      //                     right: width * 0.1,
                      //                   ),
                      //                   decoration: BoxDecoration(
                      //                     color: AppColors.White,
                      //                     borderRadius:
                      //                         BorderRadius.circular(12),
                      //                     boxShadow: const [
                      //                       BoxShadow(
                      //                         color: AppColors.Grey,
                      //                         blurRadius: 5,
                      //                         offset: Offset(0, 2),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   child: Text(
                      //                     "Xác thực",
                      //                     style: AppTextStyle.lato.copyWith(
                      //                         fontSize: 16,
                      //                         color: AppColors.Black),
                      //                   ),
                      //                 ),
                      //         ),
                      //     ],
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
            // child: Column(
            //   children: [
            //     SizedBox(
            //       height: height * 0.05,
            //     ),
            //     Align(
            //       alignment: Alignment.topLeft,
            //       child: IconButton(
            //         onPressed: () {
            //           Navigator.of(context).pop();
            //         },
            //         icon: const Icon(
            //           Icons.arrow_back_ios_new,
            //           color: AppColors.White,
            //         ),
            //       ),
            //     ),
            //     const Spacer(
            //       flex: 2,
            //     ),
            //     Expanded(
            //       flex: 6,
            //       child: Column(
            //         children: [
            //           Stack(
            //             children: [
            //               Center(
            //                 child: Text(
            //                   "Nhập số điện thoại mới",
            //                   style: AppTextStyle.lato.copyWith(
            //                     fontSize: 22,
            //                     foreground: Paint()
            //                       ..style = PaintingStyle.stroke
            //                       ..strokeWidth = 1
            //                       ..color = AppColors.Black.withOpacity(0.2),
            //                   ),
            //                 ),
            //               ),
            //               Center(
            //                 child: Text(
            //                   "Nhập số điện thoại mới",
            //                   style: AppTextStyle.lato.copyWith(
            //                     fontSize: 22,
            //                     color: AppColors.White,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: height * 0.05,
            //           ),
            //           Container(
            //             margin: const EdgeInsets.symmetric(horizontal: 20),
            //             decoration: BoxDecoration(
            //               color: AppColors.White.withOpacity(0.8),
            //               borderRadius: BorderRadius.circular(15),
            //               border: Border.all(
            //                 color: AppColors.Black.withOpacity(0.5),
            //                 width: 1,
            //               ),
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.only(top: 13),
            //               child: Column(
            //                 children: [
            //                   Text(
            //                     "Số điện thoại",
            //                     style: AppTextStyle.lato.copyWith(
            //                       fontSize: 14,
            //                       color: AppColors.Black.withOpacity(0.5),
            //                     ),
            //                   ),
            //                   TextField(
            //                     textAlign: TextAlign.center,
            //                     controller: phoneNumberController,
            //                     keyboardType: TextInputType.number,
            //                     readOnly: _isWaiting == true ? true : false,
            //                     decoration: InputDecoration(
            //                       border: InputBorder.none,
            //                       contentPadding: const EdgeInsets.all(0),
            //                       hintText: "Nhập số điện thoại",
            //                       hintStyle: AppTextStyle.lato.copyWith(
            //                         fontSize: 18,
            //                         color: AppColors.Black.withOpacity(0.5),
            //                       ),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: height * 0.05,
            //           ),
            //           InkWell(
            //             onTap: () {
            //               user.setIsSent(false);
            //               user.setChangePhoneFail(false);

            //               if (_isWaiting == false) {
            //                 setState(() {
            //                   otpController.text = "";
            //                 });
            //               }
            //               if (_isOTPSent == true && _isWaiting == false) {
            //                 setState(() {
            //                   _isValidOTP = null;
            //                 });
            //               }
            //               if (phoneNumberController.text.isValidPhoneNumber()) {
            //                 setState(() {
            //                   _isValidPhoneNumber = true;
            //                 });
            //                 if ((_isWaiting == null || _isWaiting == false)) {
            //                   startTimer();
            //                   profileProvider!.sendOTPToChangePhoneNumber(
            //                       widget.mdUser!, context);
            //                   setState(() {
            //                     _isOTPSent = true;
            //                     _isWaiting = true;
            //                   });
            //                 }
            //               } else {
            //                 setState(() {
            //                   _isValidPhoneNumber = false;
            //                 });
            //               }
            //             },
            //             child: Column(
            //               children: [
            //                 if (_isValidPhoneNumber == false)
            //                   Text(
            //                     "Số điện thoại không hợp lệ",
            //                     style: AppTextStyle.lato.copyWith(
            //                       fontSize: 14,
            //                       color: AppColors.Red,
            //                     ),
            //                   ),
            //                 if (_isValidPhoneNumber == false)
            //                   SizedBox(
            //                     height: height * 0.01,
            //                   ),
            //                 if (_isOTPSent == false)
            //                   ButtonContainer(
            //                     height: height,
            //                     width: width,
            //                     text: "Gửi mã OTP",
            //                     color: const Color(0xFF5FC5FF),
            //                   ),
            //                 if (_isOTPSent == true &&
            //                     _isWaiting == true &&
            //                     user.isSent == true)
            //                   ButtonContainer(
            //                     height: height,
            //                     width: width,
            //                     text: sec / 10 == 0
            //                         ? "0$min:0$sec"
            //                         : "0$min:$sec",
            //                     color: const Color(0xFFCDCDCD),
            //                   ),
            //                 if (_isOTPSent == true && _isWaiting == false)
            //                   ButtonContainer(
            //                     height: height,
            //                     width: width,
            //                     text: "Gửi lại OTP",
            //                     color: const Color(0xFF5FC5FF),
            //                   ),
            //               ],
            //             ),
            //           ),
            //           if (_isOTPSent)
            //             Column(
            //               children: [
            //                 SizedBox(
            //                   height: height * 0.08,
            //                 ),
            //                 SizedBox(
            //                   width: width * 0.7,
            //                   child: Text(
            //                     user.isSent == true && _isWaiting == true
            //                         ? user.changePhoneFail
            //                             ? "OTP không đúng"
            //                             : "Đã gửi OTP, vui lòng check trong hộp thư Email của bạn và điền mã OTP vào ô dưới đây"
            //                         : _isWaiting == true
            //                             ? ''
            //                             : "OTP đã hết hạn, vui lòng gửi lại OTP",
            //                     style: AppTextStyle.lato.copyWith(
            //                         fontSize: 13, color: AppColors.Red),
            //                     textAlign: TextAlign.center,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: height * 0.015,
            //                 ),
            //                 Container(
            //                   margin: const EdgeInsets.symmetric(
            //                     horizontal: 20,
            //                   ),
            //                   decoration: BoxDecoration(
            //                     color: AppColors.White.withOpacity(0.8),
            //                     borderRadius: BorderRadius.circular(12),
            //                     boxShadow: const [
            //                       BoxShadow(
            //                         color: AppColors.Grey,
            //                         blurRadius: 10,
            //                         offset: Offset(0, 2),
            //                       ),
            //                     ],
            //                   ),
            //                   child: Padding(
            //                     padding: const EdgeInsets.only(top: 0),
            //                     child: Form(
            //                       key: _otpFormKey,
            //                       child: TextFormField(
            //                         controller: otpController,
            //                         textAlign: TextAlign.center,
            //                         readOnly:
            //                             user.isSent == true ? false : true,
            //                         style: const TextStyle(fontSize: 18),
            //                         keyboardType: TextInputType.number,
            //                         inputFormatters: [
            //                           LengthLimitingTextInputFormatter(6)
            //                         ],
            //                         onChanged: (value) => otp = value,
            //                         validator: (value) {
            //                           if (value != null) {
            //                             if (value.length < 6) {
            //                               user.setChangePhoneFail(true);
            //                               return '';
            //                             }
            //                           }
            //                           setState(() {
            //                             _isValidOTP = true;
            //                           });
            //                           return null;
            //                         },
            //                         decoration: const InputDecoration(
            //                           hintText: "Nhập mã OTP",
            //                           border: InputBorder.none,
            //                           errorStyle: TextStyle(height: 0),
            //                           contentPadding: EdgeInsets.all(0),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: height * 0.03,
            //                 ),
            //                 InkWell(
            //                   onTap: () async {
            //                     user.setChangePhoneFail(false);

            //                     if (_isWaiting == true && _isWaiting != null) {
            //                       if (min >= 0 && sec > 0) {
            //                         if (_otpFormKey.currentState!.validate()) {
            //                           if (_isValidOTP == true) {
            //                             if (_isValidOTP == true &&
            //                                 _isOTPSent == true &&
            //                                 phoneNumberController
            //                                     .text.isNotEmpty) {
            //                               await profileProvider!
            //                                   .changePhoneNumber(
            //                                 context,
            //                                 widget.mdUser,
            //                                 phoneNumberController.text,
            //                                 otp!,
            //                               );
            //                               getSharedPreferences();
            //                               setState(() {
            //                                 _isValidOTP =
            //                                     pref!.getBool("isValidOTP");
            //                               });
            //                             }
            //                           }
            //                         }
            //                       }
            //                     }
            //                   },
            //                   child: user.isLoading
            //                       ? const Center(
            //                           child: CircularProgressIndicator())
            //                       : ButtonContainer(
            //                           height: height,
            //                           width: width,
            //                           text: "Xác thực",
            //                           color: _isWaiting == false
            //                               ? const Color(0xFFCDCDCD)
            //                               : AppColors.White),
            //                 ),
            //               ],
            //             ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.color,
  }) : super(key: key);
  final String text;
  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.23,
      ),
      padding: EdgeInsets.only(
        top: height * 0.013,
        bottom: height * .013,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.Grey,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyle.lexendExa.copyWith(
            fontSize: 16,
            color: AppColors.Black,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/src/screens/register%20screen/register_info_screen.dart';
import 'package:untitled/src/screens/register%20screen/register_otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repository/auth/authAPI_provider.dart';
import '../../utils/app_constant/app_colors.dart';

class OTPProvider extends ChangeNotifier {
  AuthAPIProvider authAPIProvider = AuthAPIProvider();
  var data;

  String _emailError = '';
  String get emailError => _emailError;
  set emailError(String value) {
    _emailError = value;
    notifyListeners();
  }

  String _otpError = '';
  String get otpError => _otpError;
  set otpError(String value) {
    _otpError = value;
    notifyListeners();
  }

  void reset() {
    _emailError = '';
    _otpError = '';
  }

  Future sendEmailOTP(
      String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.DarkPink,
            ),
          );
        });
    data = await authAPIProvider.sendEmailOTP(email);
    print(data);

    //Dừng trạng thái loading
    Navigator.of(context).pop();

    // kiểm tra reponse từ api
    if (data['success'] == true) {
      //Gửi OTP thành công
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Đã gửi OTP. Hãy kiểm tra hộp thư của bạn.')));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RegisterOTPScreen(
          email: email,
          password: password,
        ),
      ));
    } else {
      String errMessage = data['error']['message'];
      if (errMessage == 'Email này đã tồn tại!') {
        emailError = errMessage;
      } else {
        // Sai thông tin dăng kí thông báo cho người dùng
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Đăng ký thất bại, kiểm tra lại thông tin')));
      }
    }
  }

  Future confirmEmailOTP(
      String email, String password, String otp, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.DarkPink,
            ),
          );
        });
    data = await authAPIProvider.confirmEmailOTP(email, otp);
    print(data);

    //Dừng trạng thái loading
    Navigator.of(context).pop();

    // kiểm tra reponse từ api
    if (data['result']['isCorrect'] == true) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RegisterInfoScreen(
          email: email,
          password: password,
          isEmail: true,
        ),
      ));
    } else {
      otpError = 'OTP không đúng!';
    }
  }

  Future sendSMSOTP(
      BuildContext context, String phoneNumber, String password) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+84 ${phoneNumber.substring(1)}',
      timeout: const Duration(seconds: 120),
      verificationCompleted: (phoneAuthCredential) async {
        await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential)
            .then((value) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RegisterInfoScreen(
              email: phoneNumber,
              password: password,
              isEmail: false,
            ),
          ));
        }).onError((error, stackTrace) {
          Navigator.of(context).pop();
          otpError = 'OTP không đúng!';
        });
      },
      verificationFailed: (error) {
        Navigator.of(context).pop();
      },
      codeSent: (verificationId, _) {
        Navigator.of(context).pop();
        //Gửi OTP thành công
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterOTPScreen(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
            password: password,
          ),
        ));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future retrySendSMSOTP(
      BuildContext context,
      String phoneNumber,
      String password,
      Function(String) onCodeSent,
      Function handleOTPSent) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+84 ${phoneNumber.substring(1)}',
      timeout: const Duration(seconds: 120),
      verificationCompleted: (phoneAuthCredential) async {
        await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential)
            .then((value) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RegisterInfoScreen(
              email: phoneNumber,
              password: password,
              isEmail: false,
            ),
          ));
        }).onError((error, stackTrace) {
          otpError = 'OTP không đúng!';
        });
      },
      verificationFailed: (error) {
        print(error);
      },
      codeSent: (verificationId, forceResendingToken) {
        //Gửi OTP thành công
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Đã gửi OTP. Hãy kiểm tra hộp thư của bạn.')));
        handleOTPSent();
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}

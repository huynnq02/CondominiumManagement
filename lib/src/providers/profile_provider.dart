import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import '../../repository/profile/profileAPI_provider.dart';
import '../../utils/helper/app_preference.dart';
import 'dart:convert';

class ProfileProvider extends ChangeNotifier {
  var reponse;
  MDUser mdUser = MDUser(
    name: "",
    surname: "",
    userName: "",
    email: "",
    password: "",
    gender: "",
    idNumber: "",
    fullName: "",
    birthDate: "",
    apartmentId: "",
    otp: "",
  );
  Future changePassword(BuildContext context, String? newPassword,
      String? newPassword1, String? curentPassword) async {
    String? password = AppPreferences.prefs.getString('password');
    // kiểm tra 2 mật khẩu mói hợp lệ
    if (newPassword == newPassword1) {
      // kiểm tra nhập đúng mật khẩu hiện tại
      if (password == curentPassword) {
        reponse = await ProfilePro().changePassword(
            currentPassword: curentPassword!, newPassword: newPassword!);
        AppPreferences.prefs.setString('password', newPassword);
        reponse == true
            ? ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cập nhật thành công')))
            : ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cập nhật thất bại')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sai mật khẩu hiện tại')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mật khẩu mới không hợp lệ')));
    }
  }

  Future getCurrentUserProfile(BuildContext context) async {
    var response = await ProfilePro().getCurrentUserProfileAPIProvider();
    print(response['result']);
    MDUser user = MDUser.fromMap(response['result']);
    return user;
    // notifyListeners();
  }

  Future getProfilePicture(BuildContext context) async {
    var response = await ProfilePro().getProfilePictureAPIProvider();
    var bytesString = response['profilePicture'] as String;
    List<int> bytesList = base64.decode(bytesString);
    Uint8List bytes = Uint8List.fromList(bytesList);
    return bytes;
  }

  Future updateProfilePicture(File image) async {
    var response = await ProfilePro().updateProfilePictureAPIProvider(image);
    return response;
  }

  Future sendOTPToChangePhoneNumber(
      MDUser? mdUser, BuildContext context) async {
    var success =
        await ProfilePro().sendOTPToChangePhoneNumberAPIProvider(mdUser);
    // kiểm tra reponse từ api
    if (success == true) {
      //Gửi OTP thành công
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gửi OTP thành công')));
    } else {
      // sai thông tin dăng kí thông báo cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Gửi OTP thất bại, kiểm tra lại thông tin')));
    }

    notifyListeners();
  }

  Future changePhoneNumber(BuildContext context, MDUser? mdUser,
      String phoneNumber, String otp) async {
    SharedPreferences pref;
    var success = await ProfilePro()
        .changePhoneNumberAPIProvider(mdUser, phoneNumber, otp);
    print(1);
    if (success == true) {
      print(2);
      print('change succeed');
      //Gửi OTP thành công
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Cập nhật thành công')));
      pref = await SharedPreferences.getInstance();

      pref.setBool("isValidOTP", true);
    } else if (success == false) {
      print("3");
      pref = await SharedPreferences.getInstance();

      pref.setBool("isValidOTP", false);
      print(pref.getBool("isValidOTP"));
      print('change failed');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Cập nhật thất bại, kiểm tra lại thông tin')));
    }
    notifyListeners();
  }
}

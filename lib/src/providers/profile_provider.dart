import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import '../../repository/profile/profileAPI_provider.dart';
import '../../utils/helper/app_preference.dart';
import 'dart:convert';

import '../screens/change phone number screen/widgets/change_phone_number_successful_dialog.dart';

class ProfileProvider extends ChangeNotifier {
  var reponse;
  bool _isSent = false;
  bool get isSent => _isSent;
  void setIsSent(bool isSent) {
    _isSent = isSent;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool _changePhoneFail = false;
  bool get changePhoneFail => _changePhoneFail;
  void setChangePhoneFail(bool changePhoneFail) {
    _changePhoneFail = changePhoneFail;
    notifyListeners();
  }

  Uint8List? _profilePicture;
  Uint8List? get profilePicture => _profilePicture;
  void setProfilePicture(Uint8List profilePicture) {
    _profilePicture = profilePicture;
    notifyListeners();
  }

  MDUser _mdUser = MDUser(
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

  MDUser get mdUser => _mdUser;
  void setMdUser(MDUser mdUser) {
    _mdUser = mdUser;
    notifyListeners();
  }

  void setEmptyUser() {
    _mdUser = MDUser(
        name: "",
        surname: "",
        email: "",
        password: "",
        gender: "",
        idNumber: "",
        fullName: "",
        birthDate: "",
        apartmentId: "",
        otp: "");
    _profilePicture = null;
    notifyListeners();
  }

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

  Future<void> getCurrentUserProfile() async {
    var response = await ProfilePro().getCurrentUserProfileAPIProvider();
    print('a : ${response['result']}');
    MDUser user = MDUser.fromMap(response['result']);
    setMdUser(user); // notifyListeners();
  }

  Future<void> getProfilePicture() async {
    var response = await ProfilePro().getProfilePictureAPIProvider();
    var bytesString = response['profilePicture'] as String;
    setProfilePicture(
      base64Decode(bytesString),
    );
  }

  Future updateProfilePicture(File image) async {
    var response = await ProfilePro().updateProfilePictureAPIProvider(image);
    return response;
  }

  Future sendOTPToChangePhoneNumber(
      MDUser? mdUser, BuildContext context) async {
    print('111');
    var success =
        await ProfilePro().sendOTPToChangePhoneNumberAPIProvider(mdUser);
    // kiểm tra reponse từ api
    if (success == true) {
      setIsSent(true);
      //Gửi OTP thành công
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Gửi OTP thành công')));
    } else {
      // sai thông tin dăng kí thông báo cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Gửi OTP thất bại, kiểm tra lại thông tin')));
    }

    notifyListeners();
  }

  void showSuccessfulDialog(BuildContext context) => showDialog(
        context: context,
        builder: ((context) => (SuccessfulDialog())),
      );

  Future changePhoneNumber(BuildContext context, MDUser? mdUser,
      String phoneNumber, String otp) async {
    SharedPreferences pref;
    setIsLoading(true);
    var success = await ProfilePro()
        .changePhoneNumberAPIProvider(mdUser, phoneNumber, otp);
    pref = await SharedPreferences.getInstance();

    if (success == true) {
      mdUser!.phoneNumber = phoneNumber;
      setMdUser(mdUser);
      // showSuccessfulDialog(context);
      pref.setBool("isValidOTP", true);

      setIsLoading(false);
    } else if (success == false) {
      setChangePhoneFail(true);
      setIsLoading(false);

      print("3");

      pref.setBool("isValidOTP", false);
      print(pref.getBool("isValidOTP"));
      print('change failed');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Cập nhật thất bại, kiểm tra lại thông tin')));
    }
  }
}

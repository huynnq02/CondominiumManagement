import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import '../../repository/profile/profileAPI_provider.dart';
import '../../utils/helper/app_preference.dart';
import 'dart:convert';

class ProfileProvider extends ChangeNotifier {
  var reponse;

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
  }

  Future getProfilePicture(BuildContext context) async {
    var response = await ProfilePro().getProfilePictureAPIProvider();
    // print("res ne");
    // print(response['profilePicture'] as String);
    // String profilePicture = response['profilePicture'] as String;
    var bytesString = response['profilePicture'] as String;
    List<int> bytesList = base64.decode(bytesString);
    print("bai lit");
    print(bytesList);
    return bytesList;
  }

  Future updateProfilePicture(File image) async {
    var response = await ProfilePro().updateProfilePictureAPIProvider(image);
    return response;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/profile/profile_repository.dart';
import 'package:untitled/src/models/user.dart';

class ProfilePro extends BaseProvider<ProfileRepository> {
  @override
  ProfileRepository initRepository() {
    return ProfileRepository();
  }

  Future changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final res = await repository.changePassword(
        currentPassword: currentPassword, newPassword: newPassword);

    return res.data['success'];
  }

  Future getProfilePictureAPIProvider() async {
    final res = await repository.getProfilePictureAPIRepository();
    String resBody = res.toString();
    var jsonData = jsonDecode(resBody);
    return jsonData['result'];
  }

  Future getCurrentUserProfileAPIProvider() async {
    final res = await repository.getCurrentUserProfileAPIRepository();

    return res.data;
  }

  Future updateProfilePictureAPIProvider(String imageUrl) async {
    final res = await repository.updateProfilePictureAPIRepository(imageUrl);
    return res.data;
  }

  Future sendOTPToChangePhoneNumberAPIProvider(MDUser? mdUser) async {
    final res =
        await repository.sendOTPToChangePhoneNumberAPIRepository(mdUser);
    print("kq ne:");
    print(res.data);
    return res.data['success'];
  }

  Future changePhoneNumberAPIProvider(
      MDUser? mdUser, String phoneNumber, String otp) async {
    final res = await repository.changePhoneNumberAPIRepository(
        mdUser, phoneNumber, otp);
    print("kq neee:");
    print(res.data['success']);
    return res.data['success'];
  }

  Future checkOTPAPIProvider(String otp, MDUser? mdUser) async {
    final res = await repository.checkOTPAPIRepository(otp, mdUser);
    print("kq neee:");
    print("check otp co thanh cong:");
    print(res.data);
    return res.data['result'];
  }
}

import 'dart:io';

import 'package:untitled/repository/base/base_provider.dart';
import 'package:untitled/repository/profile/profile_repository.dart';

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
    print(res.data['result']);
    return res.data['result'];
  }

  Future getCurrentUserProfileAPIProvider() async {
    final res = await repository.getCurrentUserProfileAPIRepository();

    return res.data;
  }

  Future updateProfilePictureAPIProvider(File file) async {
    final res = await repository.updateProfilePictureAPIRepository(file);
    return res.data;
  }
}

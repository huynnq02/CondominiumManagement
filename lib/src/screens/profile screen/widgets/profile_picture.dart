import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/repository/profile/profileAPI_provider.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:untitled/utils/helper/storage_methods.dart';

class ProfilePicture extends StatefulWidget {
  ProfilePicture({Key? key}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<ProfileProvider>();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      // set overflow for stack
      clipBehavior: Clip.none,
      children: [
        Container(
          height: width * 0.25,
          width: width * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.Black, width: 1),
            image: DecorationImage(
              image: user.profilePicture != null
                  ? NetworkImage(user.profilePicture!) as ImageProvider
                  : const AssetImage("assets/default-profile-picture.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -13,
          right: 3,
          child: SizedBox(
            width: width * 0.05,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF55F75C),
              child: const ImageIcon(
                AssetImage('assets/change-profile-picture-icon.png'),
                color: AppColors.White,
                size: 10,
              ),
              onPressed: _showModalBottomSheet,
            ),
          ),
        )
      ],
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (builder) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return Container(
          height: height * 0.197,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: height * 0.065,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Center(
                  child: Text("Chỉnh sửa ảnh đại diện",
                      style: AppTextStyle.lato.copyWith(fontSize: 16)),
                ),
              ),
              SizedBox(
                height: height * 0.001,
              ),
              Container(
                height: height * 0.065,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.camera_alt,
                              size: 29,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chụp ảnh",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFF12C82F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      takePhoto(ImageSource.camera);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.001,
              ),
              Container(
                height: height * 0.065,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColors.White,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: ImageIcon(
                              AssetImage('assets/galery-icon.png'),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chọn từ thư viện ảnh",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFF12C82F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void takePhoto(ImageSource source) async {
    final _pickedFile = await _picker.getImage(source: source);
    if (_pickedFile != null) {
      setState(() {
        _imageFile = _pickedFile;
        uploadImage(_imageFile!);
      });
    }
  }

  // upload _imageFile to api
  void uploadImage(PickedFile _imageFile) async {
    final user = context.read<ProfileProvider>().mdUser;
    final _image = File(_imageFile.path);
    Uint8List avatar = await _image.readAsBytes();
    String imageUrl = await StorageMethods()
        .uploadImageToStorage('profilePics', avatar, false, user.idNumber);
    print('url anh: $imageUrl');

    await ProfilePro().updateProfilePictureAPIProvider(imageUrl);
    context.read<ProfileProvider>().setProfilePicture(imageUrl);
  }
}

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
import 'package:iconsax/iconsax.dart' as ic;

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
          height: width * 0.3,
          width: width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: const Color(0xFFFFFFFF), width: 3),
            image: user.profilePicture != null
                ? DecorationImage(
                    image: NetworkImage(user.profilePicture!),
                    fit: BoxFit.cover,
                  )
                : null,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: user.profilePicture == null
              ? Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xFFD9D9D9),
                      ),
                    ),
                    const Center(
                      child: Icon(
                        ic.Iconsax.user,
                        color: Color(0xFF7D7D7D),
                        size: 40,
                      ),
                    )
                  ],
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 12,
          child: SizedBox(
            height: height * 0.032,
            width: height * 0.032,
            child: FloatingActionButton(
              shape: const StadiumBorder(
                side: BorderSide(color: Color(0xFF9B8E8E), width: 1),
              ),
              // set size for floating action buton
              mini: true,

              backgroundColor: AppColors.White,
              child: Icon(
                ic.Iconsax.edit_2,
                color: AppColors.Black,
                size: height * 0.018,
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
                decoration: BoxDecoration(
                  color: AppColors.White,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text("Chỉnh sửa ảnh đại diện",
                      style: AppTextStyle.lato.copyWith(fontSize: 16)),
                ),
              ),
              Container(
                height: height * 0.065,
                width: width,
                decoration: BoxDecoration(
                  color: AppColors.White,
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.1),
                            child: const ImageIcon(
                              AssetImage('assets/camera-icon.png'),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chụp ảnh",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFFFE2C6B),
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
              Container(
                height: height * 0.065,
                width: width,
                decoration: BoxDecoration(
                  color: AppColors.White,
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.1),
                            child: const ImageIcon(
                              AssetImage('assets/gallery-icon.png'),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chọn từ thư viện ảnh",
                            style: AppTextStyle.lato.copyWith(
                              fontSize: 16,
                              color: const Color(0xFFFE2C6B),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'dart:convert';

import 'package:untitled/utils/app_constant/app_text_style.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  ProfileProvider? profileProvider;
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    getUserProfilePicture();
  }

  void getUserProfilePicture() async {
    await profileProvider?.getProfilePicture(context);
  }

  @override
  Widget build(BuildContext context) {
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
            borderRadius: const BorderRadius.all(
              Radius.circular(35),
            ),
            border: Border.all(color: AppColors.Black, width: 1),
            image: DecorationImage(
              image: _imageFile == null
                  ? const AssetImage("assets/default-profile-picture.png")
                  : FileImage(
                      File(_imageFile!.path),
                    ) as ImageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: -15,
          right: -1,
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
                        const Positioned(
                          left: 10,
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.Black,
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
                        const Positioned(
                          left: 10,
                          child: ImageIcon(
                            AssetImage('assets/galery-icon.png'),
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
    setState(() {
      _imageFile = _pickedFile;
      uploadImage(_imageFile!);
    });
  }

  // upload _imageFile to api
  void uploadImage(PickedFile _imageFile) async {
    await profileProvider?.updateProfilePicture(
      context,
      File(_imageFile.path),
    );
  }
}

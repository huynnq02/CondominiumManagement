import "package:flutter/material.dart";
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/screens/profile%20screen/widgets/profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileProvider? profileProvider;
  late MDUser mdUser;

  bool _isEditingPhoneNumber = false,
      _isEditingIdNumber = false,
      _isObsecurePhoneNumber = true,
      _isObsecureIdNumber = true,
      _isLoading = false;

  final phoneController = TextEditingController();
  final idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    getUserInfomation();
  }

  void getUserInfomation() async {
    setState(() {
      _isLoading = true;
    });
    mdUser = await profileProvider?.getCurrentUserProfile(context);
    setState(() {
      _isLoading = false;
    });
  }

  void _handleWatchPhoneNumber() {
    setState(() {
      _isObsecurePhoneNumber = !_isObsecurePhoneNumber;
    });
  }

  void _handleWatchIdNumber() {
    setState(() {
      _isObsecureIdNumber = !_isObsecureIdNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/login-screen-background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  ProfilePicture(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    mdUser.surname + " " + mdUser.name,
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 48,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Flexible(
                    flex: 6,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.05,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color(0xFF00000033).withOpacity(0.20),
                                width: 1),
                            color: AppColors.White,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.Grey,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                Text(
                                  mdUser.email,
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.001),
                        Container(
                          height: height * 0.05,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color(0xFF00000033).withOpacity(0.20),
                                width: 1),
                            color: AppColors.White,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.Grey,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Giới tính",
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                Text(
                                  mdUser.gender,
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.001),
                        Container(
                          height: height * 0.05,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color(0xFF00000033).withOpacity(0.20),
                                width: 1),
                            color: AppColors.White,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.Grey,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ngày sinh",
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                Text(
                                  mdUser.birthDate,
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.001),
                        Container(
                          height: height * 0.05,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color(0xFF00000033).withOpacity(0.20),
                                width: 1),
                            color: AppColors.White,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.Grey,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "CMND/CCCD",
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _isObsecureIdNumber
                                          ? "*" * mdUser.idNumber.length
                                          : mdUser.idNumber,
                                      style: AppTextStyle.lato
                                          .copyWith(fontSize: 16),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        _isObsecureIdNumber
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: _handleWatchIdNumber,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.001),
                        Container(
                          height: height * 0.05,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color(0xFF00000033).withOpacity(0.20),
                                width: 1),
                            color: AppColors.White,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.Grey,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Số điện thoại",
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      mdUser.phoneNumber == null
                                          ? "Chưa cập nhật"
                                          : "OK",
                                    ),
                                    mdUser.phoneNumber != null
                                        ? Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  _isObsecurePhoneNumber
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                ),
                                                onPressed:
                                                    _handleWatchPhoneNumber,
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.edit),
                                              ),
                                            ],
                                          )
                                        : IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.edit),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.001),
                        Container(
                          height: height * 0.05,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color(0xFF00000033).withOpacity(0.20),
                                width: 1),
                            color: AppColors.White,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.Grey,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mã căn hộ",
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                Text(
                                  "Email",
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

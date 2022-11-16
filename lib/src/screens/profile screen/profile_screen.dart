import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:untitled/src/models/user.dart';
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/screens/change%20phone%20number%20screen/change_phone_number_screen.dart';
import 'package:untitled/src/screens/forget%20password%20screen/update_new_password_screen.dart';
import 'package:untitled/src/screens/logout%20screen/logout_confirm_dialog.dart';
import 'package:untitled/src/screens/profile%20screen/widgets/profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/screens/profile%20screen/widgets/user_info.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isObsecurePhoneNumber = true, _isObsecureIdNumber = true;

  final phoneController = TextEditingController();
  bool isLoading = false;
  final idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    if (profileProvider.mdUser.birthDate.length == 0 &&
        profileProvider.profilePicture == null) {
      setState(() {
        isLoading = true;
      });
      // profileProvider.getCurrentUserProfile();
      // profileProvider.getProfilePicture();
    }
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

  String formatDatetime(String x) {
    final date = DateTime.parse(x);
    String day =
        date.day / 10 < 1 ? "0" + date.day.toString() : date.day.toString();
    String month = date.month / 10 < 1
        ? "0" + date.month.toString()
        : date.month.toString();

    final formattedDate = "$day/$month/${date.year}";
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileProvider>(context);
    if (user.mdUser.birthDate.isNotEmpty && user.profilePicture != null) {
      setState(() {
        isLoading = false;
      });
    }
    print(user.profilePicture == null);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
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
              ProfilePicture(
                image: user.profilePicture,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                user.mdUser.surname + ' ' + user.mdUser.name,
                style: AppTextStyle.lato.copyWith(
                  fontSize: 35,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Flexible(
                flex: 6,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        border: Border.all(
                            color: const Color(0x00000033).withOpacity(0.20),
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
                              'Email',
                              style: AppTextStyle.lato.copyWith(fontSize: 16),
                            ),
                            Text(
                              user.mdUser.email,
                              style: AppTextStyle.lato.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.001),
                    UserInfo(
                      info: 'Giới tính',
                      value: user.mdUser.gender,
                    ),
                    SizedBox(height: height * 0.001),
                    UserInfo(
                      info: 'Ngày sinh',
                      value: formatDatetime(
                        user.mdUser.birthDate,
                      ),
                    ),
                    SizedBox(height: height * 0.001),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF00000033).withOpacity(0.20),
                          width: 1,
                        ),
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
                              style: AppTextStyle.lato.copyWith(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Text(
                                  _isObsecureIdNumber
                                      ? "*" * user.mdUser.idNumber.length
                                      : user.mdUser.idNumber,
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                InkWell(
                                  child: Icon(
                                    _isObsecureIdNumber
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onTap: _handleWatchIdNumber,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.001),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF00000033).withOpacity(0.20),
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
                              style: AppTextStyle.lato.copyWith(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Text(
                                  user.mdUser.phoneNumber == null
                                      ? "Chưa cập nhật"
                                      : _isObsecurePhoneNumber
                                          ? "*" *
                                              user.mdUser.phoneNumber!.length
                                          : user.mdUser.phoneNumber!,
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                user.mdUser.phoneNumber != null
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          InkWell(
                                            child: Icon(
                                              _isObsecurePhoneNumber
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onTap: _handleWatchPhoneNumber,
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChangePhoneNumberScreen(
                                                    mdUser: user.mdUser,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(Icons.edit),
                                          )
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChangePhoneNumberScreen(
                                                    mdUser: user.mdUser,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(Icons.edit),
                                          ),
                                        ],
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.001),
                    UserInfo(
                      info: 'Mã căn hộ',
                      value: user.mdUser.apartmentId ?? '',
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0x00000033).withOpacity(0.20),
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
                              "Đổi mật khẩu",
                              style: AppTextStyle.lato.copyWith(fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) =>
                                        const UpdateNewPasswordScreen(
                                          isLoggedIn: true,
                                        ))));
                              },
                              child: const Icon(Icons.lock_reset),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(
                            color: const Color(0x00000033).withOpacity(0.20),
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
                              "Đăng xuất",
                              style: AppTextStyle.lato.copyWith(fontSize: 16),
                            ),
                            InkWell(
                              onTap: () => showLogoutConfirmPopupDialog(
                                  context, height, width),
                              child: const Icon(Icons.logout),
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

  void showLogoutConfirmPopupDialog(BuildContext context, height, width) =>
      showDialog(
          context: context, builder: ((context) => LogOutConfirmDialog()));
}

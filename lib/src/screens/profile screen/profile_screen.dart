import "package:flutter/material.dart";
import 'package:untitled/src/providers/profile_provider.dart';
import 'package:untitled/src/screens/logout%20screen/logout_confirm_dialog.dart';
import 'package:untitled/src/screens/profile%20screen/widgets/profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/screens/profile%20screen/widgets/user_info.dart';
import 'package:untitled/src/screens/profile%20screen/widgets/user_option.dart';
import 'package:untitled/src/screens/security%20screen/security_screen.dart';

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
    print('userProfile: ${user.profilePicture == null}');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: height,
              minWidth: width,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  ProfilePicture(),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    user.mdUser.surname + ' ' + user.mdUser.name,
                    style: AppTextStyle.lato.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Flexible(
                    flex: 6,
                    child: Column(
                      children: [
                        UserInfo(
                          info: 'Ngày sinh',
                          value: formatDatetime(
                            user.mdUser.birthDate,
                          ),
                          icon: 'birthday-cake-icon',
                          topRadius: 8,
                        ),
                        UserInfo(
                            info: 'Giới tính',
                            value: user.mdUser.gender,
                            icon: 'gender-icon'),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF000033).withOpacity(0.20),
                              width: 1,
                            ),
                            color: AppColors.White,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/identify-icon.png'),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  "CMND/CCCD",
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      _isObsecureIdNumber
                                          ? "*" * user.mdUser.idNumber.length
                                          : user.mdUser.idNumber,
                                      style: AppTextStyle.lato
                                          .copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    InkWell(
                                      child: ImageIcon(
                                        _isObsecureIdNumber
                                            ? const AssetImage(
                                                'assets/invisible-icon.png')
                                            : const AssetImage(
                                                'assets/visible-icon.png'),
                                      ),
                                      onTap: _handleWatchIdNumber,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        UserInfo(
                          info: 'Mã căn hộ',
                          value: user.mdUser.apartmentId ?? '',
                          icon: 'apartment-icon',
                          bottomRadius: 8,
                          shadow: true,
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        UserInfo(
                          info: 'Email',
                          value: user.mdUser.email,
                          icon: 'email-icon',
                          topRadius: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            border: Border.all(
                                color:
                                    const Color(0xFF00000033).withOpacity(0.20),
                                width: 1),
                            color: AppColors.White,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                blurRadius: 3,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/phone-icon.png'),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  "Số điện thoại",
                                  style:
                                      AppTextStyle.lato.copyWith(fontSize: 16),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      user.mdUser.phoneNumber == null
                                          ? "Chưa cập nhật"
                                          : _isObsecurePhoneNumber
                                              ? "*" *
                                                  user.mdUser.phoneNumber!
                                                      .length
                                              : user.mdUser.phoneNumber!,
                                      style: AppTextStyle.lato
                                          .copyWith(fontSize: 16),
                                    ),
                                    if (user.mdUser.phoneNumber != null)
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          InkWell(
                                            child: ImageIcon(
                                              _isObsecurePhoneNumber
                                                  ? const AssetImage(
                                                      'assets/invisible-icon.png')
                                                  : const AssetImage(
                                                      'assets/visible-icon.png'),
                                            ),
                                            onTap: _handleWatchPhoneNumber,
                                          ),

                                          // InkWell(
                                          //   onTap: () {
                                          //     Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             ChangePhoneNumberScreen(
                                          //           mdUser: user.mdUser,
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          //   child: const Icon(Icons.edit),
                                          // )
                                        ],
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.symmetric(horizontal: 10),
                        //   decoration: BoxDecoration(
                        //     borderRadius: const BorderRadius.only(
                        //       bottomLeft: Radius.circular(10),
                        //       bottomRight: Radius.circular(10),
                        //     ),
                        //     border: Border.all(
                        //         color: const Color(0x00000033).withOpacity(0.20),
                        //         width: 1),
                        //     color: AppColors.White,
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Row(
                        //       children: [
                        //         const Image(
                        //           image: AssetImage('assets/reset-password-icon.png'),
                        //         ),
                        //         SizedBox(
                        //           width: width * 0.02,
                        //         ),
                        //         Text(
                        //           "Đổi mật khẩu",
                        //           style: AppTextStyle.lato.copyWith(fontSize: 16),
                        //         ),
                        //         const Spacer(),
                        //         InkWell(
                        //           onTap: () {
                        //             Navigator.of(context).push(MaterialPageRoute(
                        //                 builder: ((context) =>
                        //                     const UpdateNewPasswordScreen(
                        //                       isLoggedIn: true,
                        //                     ))));
                        //           },
                        //           child: const Icon(
                        //             Icons.arrow_forward_ios,
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        const UserOption(
                          leadingIcon: "setting-icon",
                          title: "Cài đặt",
                          icon: "black-arrow-right-icon",
                          topRadius: 8,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => SecurityScreen(
                                      mdUser: user.mdUser,
                                    ))));
                          },
                          child: const UserOption(
                            leadingIcon: "security-icon",
                            title: "Bảo mật",
                            icon: "black-arrow-right-icon",
                            bottomRadius: 8,
                            shadow: true,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        InkWell(
                          onTap: () => showLogoutConfirmPopupDialog(
                              context, height, width),
                          child: const UserOption(
                            leadingIcon: "logout-icon",
                            title: "Đăng xuất",
                            icon: "white-arrow-right-icon",
                            bottomRadius: 8,
                            topRadius: 8,
                            textColor: Color(0xFFFFFFFF),
                            backgroundColor: Color(0xFFDB2F68),
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.symmetric(horizontal: 10),
                        //   decoration: BoxDecoration(
                        //     borderRadius: const BorderRadius.all(
                        //       Radius.circular(10),
                        //     ),
                        //     border: Border.all(
                        //         color:
                        //             const Color(0x00000033).withOpacity(0.20),
                        //         width: 1),
                        //     color: AppColors.White,
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         const Image(
                        //             image:
                        //                 AssetImage('assets/logout-icon.png')),
                        //         SizedBox(
                        //           width: width * 0.02,
                        //         ),
                        //         Text(
                        //           "Đăng xuất",
                        //           style:
                        //               AppTextStyle.lato.copyWith(fontSize: 16),
                        //         ),
                        //         const Spacer(),
                        //         InkWell(
                        //           onTap: () => showLogoutConfirmPopupDialog(
                        //               context, height, width),
                        //           child: const Icon(Icons.arrow_forward_ios),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showLogoutConfirmPopupDialog(BuildContext context, height, width) =>
      showDialog(
          context: context, builder: ((context) => LogOutConfirmDialog()));
}

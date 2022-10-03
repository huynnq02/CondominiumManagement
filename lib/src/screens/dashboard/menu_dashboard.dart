import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/screens/dashboard/change_password_screen.dart';
import 'package:untitled/src/screens/dashboard/dashboard_screen%20copy.dart';
import 'package:untitled/src/screens/dashboard/dashboard_screen.dart';
import 'package:untitled/src/screens/dashboard/product_manage/dashboard_product_manage_screen.dart';
import 'package:untitled/src/screens/dashboard/widget/menu_item.dart';
import 'package:untitled/src/screens/main%20screen/main_screen.dart';
import 'package:untitled/src/screens/register%20screen/setting_account_screen.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../providers/repository_provider.dart';

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({Key? key}) : super(key: key);

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> {
  late LoginProvider loginProvider;

  late RepositoryProvider getPhonesProvider;
  Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);

    getPhonesProvider = Provider.of<RepositoryProvider>(context, listen: false);

    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.White,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.grey.shade700,
                  size: 35,
                ))
          ],
        ),
        body: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.all(40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              checkScreen: true,
                            ),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: MenuItem(
                        title: 'Trang chủ',
                        icon: Icons.home,
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen()));
                      },
                      child: MenuItem(
                        title: 'Dashboard 1',
                        icon: Icons.dashboard,
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen2()));
                      },
                      child: MenuItem(
                        title: 'Dashboard 2',
                        icon: Icons.dashboard,
                      )),
                  GestureDetector(
                      onTap: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DashBoardProductManageScreen(
                            listPhone: getPhonesProvider.phones,
                          ),
                        ));
                      }),
                      child: MenuItem(
                        title: 'Quản lý',
                        icon: Icons.manage_accounts,
                      )),
                  InkWell(
                    child: MenuItem(
                      title: 'Đổi mật khẩu',
                      icon: Icons.key,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChagePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MailCertificateScreen(), //test screen
                        ),
                      );
                    },
                    child: MenuItem(
                      title: 'Cài đặt tài khoản',
                      icon: Icons.settings,
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      removeToken(); //remove token khi đăng xuất
                      loginProvider.check = false;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainScreen(
                          checkScreen: false,
                        ),
                      ));
                    }),
                    child: MenuItem(
                      title: 'Đăng xuất',
                      icon: Icons.logout,
                    ),
                  )
                ],
              ),
            )));
  }
}

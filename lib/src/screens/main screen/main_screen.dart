import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import 'package:untitled/src/screens/feedback%20screen/feedback_screen.dart';
import 'package:untitled/src/screens/home%20screen/home_screen.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';
import 'package:untitled/src/screens/main%20screen/widgets/information.dart';
import 'package:untitled/src/screens/profile%20screen/profile_screen.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import '../../../utils/app_constant/app_text_style.dart';
import '../../../utils/helper/app_preference.dart';

class MainScreen extends StatefulWidget {
  bool checkScreen;
  MainScreen({
    required this.checkScreen,
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late RepositoryProvider provider;
  LoginProvider? loginProvider;
  String? email;
  int _selectedIndex = 0;
  void _onTapTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final pages = [
    const HomeScreen(),
    FeedbackScreen(),
    const Center(
      child: Text("Screen 3"),
    ),
    const Center(
      child: Text("Screen 4"),
    ),
    ProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
// lấy email và password để cập nhật token mới
    loginProvider!.checkSave();

    provider = Provider.of<RepositoryProvider>(context, listen: false);
    String? token = AppPreferences.prefs.getString('token');
    email = AppPreferences.prefs.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: widget.checkScreen
            ? pages[_selectedIndex]
            : SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.only(right: 15, bottom: 29),
                          // child:
                          loginProvider!.check == true &&
                                  widget.checkScreen == true
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    ).then((value) => setState(() {}));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        color: AppColors.LightBlue,
                                        size: 17,
                                      ),
                                      Text(
                                        'Xin chào, ' + email.toString(),
                                        style: GoogleFonts.roboto(
                                          textStyle: AppTextStyle.robotoSize14
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    ).then((value) => setState(() {}));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        color: AppColors.LightBlue,
                                        size: 17,
                                      ),
                                      Text(
                                        'Đăng nhập',
                                        style: GoogleFonts.roboto(
                                          textStyle: AppTextStyle.robotoSize14
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                    ],
                                  ),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Image.asset('assets/logo.png'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          const SizedBox(
                            height: 33,
                          ),
                          Stack(
                            children: [
                              Image.asset('assets/slide.png'),
                              Container(
                                child: const Information(),
                                margin: const EdgeInsets.only(top: 72),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: widget.checkScreen
            ? BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                          'assets/bottom_navigation_bar_icon/home.png'),
                      color: _selectedIndex == 0
                          ? const Color(0xFF1D6D54)
                          : AppColors.Black,
                    ),
                    label: 'Trang chủ',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                          'assets/bottom_navigation_bar_icon/2.png'),
                      color: _selectedIndex == 1
                          ? const Color(0xFF1D6D54)
                          : AppColors.Black,
                    ),
                    label: "?",
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                          'assets/bottom_navigation_bar_icon/global.png'),
                      color: _selectedIndex == 2
                          ? const Color(0xFF1D6D54)
                          : AppColors.Black,
                    ),
                    label: '?',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                          'assets/bottom_navigation_bar_icon/4.png'),
                      color: _selectedIndex == 3
                          ? const Color(0xFF1D6D54)
                          : AppColors.Black,
                    ),
                    label: '?',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                          'assets/bottom_navigation_bar_icon/profile.png'),
                      color: _selectedIndex == 4
                          ? const Color(0xFF1D6D54)
                          : AppColors.Black,
                    ),
                    label: 'Cá nhân',
                  ),
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: AppColors.Black,
                selectedItemColor: const Color(0xFF1D6D54),
                unselectedLabelStyle: AppTextStyle.robotoSize14.copyWith(
                  fontSize: 10,
                ),
                selectedLabelStyle: AppTextStyle.robotoSize14.copyWith(
                  fontSize: 10,
                ),
                showUnselectedLabels: true,
                onTap: _onTapTapped,
                // elevation: 0,
              )
            : null,
      ),
    );
  }
}

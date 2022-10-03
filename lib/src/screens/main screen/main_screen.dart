import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/login_provider.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import 'package:untitled/src/screens/dashboard/menu_dashboard.dart';
import 'package:untitled/src/screens/login%20screen/login_screen.dart';
import 'package:untitled/src/screens/main%20screen/widgets/information.dart';
import 'package:untitled/src/screens/main%20screen/widgets/search_bar.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import '../../../utils/app_constant/app_text_style.dart';
import '../../../utils/helper/app_preference.dart';
import '../search screen/widget/widget_load.dart';

class MainScreen extends StatefulWidget {
  bool? checkScreen;
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
        child: Scaffold(
      body: FutureBuilder(
          future: provider.getPhones(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
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
                                            builder: (context) =>
                                                const MenuDashboard()),
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                            builder: (context) =>
                                                LoginScreen()),
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
                            SearchBar(listPhone: provider.phones),
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
                  )
                : snapshot.hasError
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error,
                              color: AppColors.Grey,
                              size: 64,
                            ),
                            Text(
                              'Có lỗi xảy ra, vui lòng thử lại sau',
                              style: AppTextStyle.nunitoBoldSize14
                                  .copyWith(fontSize: 24),
                            ),
                          ],
                        ),
                      )
                    : const WidgetLoad();
          }),
    ));
  }
}

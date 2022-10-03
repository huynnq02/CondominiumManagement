import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/src/screens/dashboard/menu_dashboard.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../widget/search_appbar.dart';

class AppBarLogo extends StatefulWidget {
  List<Phone> listPhone;
  AppBarLogo({Key? key, required this.listPhone}) : super(key: key);

  @override
  State<AppBarLogo> createState() => _AppBarLogoState();
}

class _AppBarLogoState extends State<AppBarLogo> {
  bool isSearching = false;

  Widget title() {
    return isSearching
        ? SearchAppBar(listPhone: widget.listPhone)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset('assets/logo.png'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.White,
      // leading: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      //   child: FilterOverlay(),
      // ),
      centerTitle: true,
      title: title(),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: GestureDetector(
            child: !isSearching
                ? SvgPicture.asset('assets/search.svg')
                : const Icon(
                    Icons.cancel,
                    color: AppColors.LightBlue,
                  ),
            onTap: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          ),
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MenuDashboard()));
            },
            child: const Icon(
              Icons.menu_outlined,
              color: AppColors.LightBlue,
              size: 35,
            ))
      ],
    );
  }
}

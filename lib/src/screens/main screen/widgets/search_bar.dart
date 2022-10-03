// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/src/screens/main%20screen/widgets/overlay.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../models/phone.dart';
import '../../search screen/seach_result_screen.dart';

class SearchBar extends StatelessWidget {
  List<Phone> listPhone;

  SearchBar({Key? key, required this.listPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(39)),
          border: Border.all(
            width: 2,
            color: AppColors.LightBlue,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchResultScreen(listResultPhone: listPhone)));
                },
                child: SvgPicture.asset('assets/search.svg')),
            SizedBox(
              width: 8,
            ),
            OverlayTextField(listPhone: listPhone),
          ],
        ),
      ),
    );
  }
}

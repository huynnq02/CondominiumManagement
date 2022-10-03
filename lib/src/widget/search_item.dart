import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/phone_rating_screen.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../models/phone.dart';

class SearchItem extends StatelessWidget {
  final inputText;
  Phone phone;
  SearchItem({
    required this.phone,
    Key? key,
    required this.inputText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      leading: SvgPicture.asset(
        'assets/search1.svg',
      ),
      title: Text(this.inputText,
          style: AppTextStyle.robotoSize14
              .copyWith(fontSize: 17, fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneRatingScreen(
              phone: phone,
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/filter_provider.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../models/phone.dart';
import '../../search screen/seach_result_screen.dart';

class SearchHistoryItem extends StatelessWidget {
  final inputText;
  final bool hasText;
  List<Phone> listResultPhone;
  SearchHistoryItem(
      {Key? key,
      required this.hasText,
      required this.inputText,
      required this.listResultPhone});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterProvider>(context, listen: false);
    return ListTile(
      minLeadingWidth: 0,
      leading: hasText
          ? SvgPicture.asset(
              'assets/search1.svg',
            )
          : SvgPicture.asset(
              'assets/history.svg',
            ),
      title: Text(this.inputText,
          style: AppTextStyle.robotoSize14
              .copyWith(fontSize: 17, fontWeight: FontWeight.w500)),
      onTap: () {
        provider.listPhoneFiltered = [];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SearchResultScreen(listResultPhone: listResultPhone),
          ),
        );
      },
    );
  }
}

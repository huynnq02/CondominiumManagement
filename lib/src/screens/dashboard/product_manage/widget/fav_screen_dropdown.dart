import 'package:flutter/material.dart';

import '../../../../../utils/app_constant/app_colors.dart';
import '../../../../../utils/app_constant/app_text_style.dart';

class FavScreenDropDown extends StatefulWidget {
  const FavScreenDropDown({Key? key}) : super(key: key);

  @override
  State<FavScreenDropDown> createState() => _FavScreenDropDownState();
}

class _FavScreenDropDownState extends State<FavScreenDropDown> {
  String dropdownValue = 'Tất cả';

  var items = [
    'Tất cả',
    'Item 1 1 11 1 11 111111111111',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.MidGrey),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: DropdownButton<String>(
          underline: SizedBox.shrink(),

          isExpanded: true,

          value: dropdownValue,

          icon: const Icon(
            Icons.expand_more,
            color: AppColors.Grey,
          ),

          iconSize: 24,

          // elevation: 16,

          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },

          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.nunitoBoldSize14
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            );
          }).toList(),
        ));
  }
}

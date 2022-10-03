import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../../models/phone.dart';
import '../../dashboard_screen.dart';

class WidgetDropdown extends StatefulWidget {
  List<Phone> listPhoneFav;
  WidgetDropdown({Key? key, required this.listPhoneFav}) : super(key: key);

  @override
  State<WidgetDropdown> createState() => _WidgetDropdownState();
}

class _WidgetDropdownState extends State<WidgetDropdown> {
  String dropdownvalue = 'Hiển thị theo';

  var items = [
    'Hiển thị theo',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          height: 45,
          width: 130,
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: DropdownButton(
            // Initial Value
            value: dropdownvalue,
            underline: DropdownButtonHideUnderline(child: Container()),
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                  value: items,
                  child: SizedBox(
                    width: 90,
                    child: Text(items,
                        style: AppTextStyle.nunitoSize13.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.Black)),
                  ));
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }
}

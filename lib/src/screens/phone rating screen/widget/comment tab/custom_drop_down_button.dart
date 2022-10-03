import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({Key? key}) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String dropdownValue = 'Mới nhất';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
            color: AppColors.DarkGrey, style: BorderStyle.solid, width: 0.5),
      ),
      child: DropdownButton(
        underline: SizedBox(),
          value: dropdownValue,
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/dropdown.svg'),
          ),
          elevation: 16,
          style: AppTextStyle.robotoSize14.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          items: <String>[
            'Mới nhất',
            'Cũ nhất',
            'Theo Giá',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 5,
                  bottom: 5,
                  right: 33,
                ),
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          }),
    );
  }
}

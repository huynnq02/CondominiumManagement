import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/filter_provider.dart';

import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class FilterRadioButton extends StatefulWidget {
  final filter;
  final index;
  const FilterRadioButton({Key? key, required this.filter, required this.index})
      : super(key: key);

  @override
  _FilterRadioButtonState createState() => _FilterRadioButtonState();
}

class _FilterRadioButtonState extends State<FilterRadioButton> {
  bool isChecked = false;
  FilterProvider? provider;
  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.Blue;
    }
    return AppColors.Grey;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<FilterProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: provider!.returnFilterType(widget.index),
          onChanged: (bool? value) {
            setState(() {
              provider!.saveChangeStateFilter(widget.index);
            });
          },
        ),
        Text(
          widget.filter,
          style: AppTextStyle.nunitoSize13.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.Grey,
          ),
        )
      ],
    );
  }
}

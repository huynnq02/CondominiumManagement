import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/bill_provider.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String _selected = "Tất cả";
  List<String> choices = <String>[
    'Tất cả',
    'Chưa thanh toán',
    'Chờ tiếp nhận',
    'Đã thanh toán',
  ];

  @override
  Widget build(BuildContext context) {
    final billProvider = Provider.of<BillProvider>(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.Black,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton(
              underline: Container(
                color: AppColors.White,
              ),
              hint: Text("Selected Blank"),
              value: _selected,
              onChanged: (newValue) {
                setState(() {
                  _selected = newValue.toString();
                });
              },
              items: [
                for (String choice in choices)
                  DropdownMenuItem(
                    child: Text(choice),
                    value: choice,
                    onTap: () {
                      context.read<BillProvider>().setStateProvider(choice);
                    },
                  ),
              ],
            ),
            // const Icon(
            //   Icons.arrow_drop_down,
            //   color: AppColors.Black,
            // )
          ],
        ),
      ),
    );
  }
}

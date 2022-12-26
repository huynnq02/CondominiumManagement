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
  String _selected = 'Tất cả';
  List<String> choices = <String>[
    'Tất cả',
    'Đã thanh toán',
    'Chưa thanh toán',
    'Từ chối thanh toán',
    'Chờ tiếp nhận',
  ];

  @override
  Widget build(BuildContext context) {
    _selected = Provider.of<BillProvider>(context).billState;
    // final billProvider = Provider.of<BillProvider>(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.05,
      decoration: BoxDecoration(
        color: const Color(0xFFFCF6F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.Black,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton(
              underline: Container(
                color: AppColors.White,
              ),
              hint: const Text("Selected Blank"),
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
                      print("ok");
                      Provider.of<BillProvider>(context, listen: false)
                          .setStateProvider(choice);
                      print(Provider.of<BillProvider>(context, listen: false)
                          .billState);
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

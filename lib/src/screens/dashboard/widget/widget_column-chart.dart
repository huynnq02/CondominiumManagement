import 'package:flutter/material.dart';
import 'package:untitled/src/screens/dashboard/widget/multi_column_chart.dart';
import 'package:untitled/src/screens/dashboard/widget/note_column_chart.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../models/phone.dart';

class WidgetColumnChart extends StatefulWidget {
  List<Phone> listPhone;
  WidgetColumnChart({Key? key, required this.listPhone}) : super(key: key);

  @override
  State<WidgetColumnChart> createState() => _WidgetColumnChartState();
}

class _WidgetColumnChartState extends State<WidgetColumnChart> {
  String dropdownvalue = 'Bộ lọc';

  // List of items in our dropdown menu
  var items = [
    'Bộ lọc',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.LightBlue, width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Đánh giá các tiêu chí',
                style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 17),
              ),
              // Row(
              //   children: [
              //     Container(
              //       alignment: Alignment.center,
              //       height: 28,
              //       width: 80,
              //       decoration: BoxDecoration(
              //           border: Border.all(width: 0.8),
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(5))),
              //       child: DropdownButton(
              //         // Initial Value
              //         value: dropdownvalue,
              //         underline: const SizedBox(),
              //         // Down Arrow Icon
              //         icon: const Icon(Icons.keyboard_arrow_down),

              //         // Array list of items
              //         items: items.map((String items) {
              //           return DropdownMenuItem(
              //             value: items,
              //             child: Text(items),
              //           );
              //         }).toList(),

              //         onChanged: (String? newValue) {
              //           setState(() {
              //             dropdownvalue = newValue!;
              //           });
              //         },
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 7,
              //     ),
              //     SizedBox(
              //       height: 28,
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           primary: AppColors.Blue,
              //         ),
              //         onPressed: () {
              //           print('tap cap nhat');
              //         },
              //         child: Text(
              //           'Cập nhật',
              //           style: AppTextStyle.nunitoSize13.copyWith(
              //               color: AppColors.White,
              //               fontSize: 12,
              //               fontWeight: FontWeight.bold),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const NoteColumnChart(),
          MultiColumnChart(
            listPhone: widget.listPhone,
          )
        ],
      ),
    );
  }
}

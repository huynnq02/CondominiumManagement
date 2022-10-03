// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/place_sale.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/system%20tab/custom_hardware_row_widget.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/system%20tab/describe_form.dart';

class PhoneHardwareTab extends StatelessWidget {
  Phone phone;
  PhoneHardwareTab({Key? key, required this.phone}) : super(key: key);
  final component = <String>[
    'Màn hình:',
    'Hệ điều hành:',
    'Camera sau:',
    'Camera trước:',
    'Chip:',
    'RAM:',
    'Bộ nhớ trong:',
    'Sim:',
    'Pin, Sạc:',
  ];
  final nameOfComponent = <String>[
    'OLED, 6.1", Super Retina XDR',
    'IOS 15',
    '2 camera 12 MP',
    '12 MP',
    'Apple A15 Bionic',
    '4 GB',
    '128 GB',
    '1 Nano SIM & 1 eSIM Hỗ trợ 5G',
    '3240 mAh, 20 W'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: component.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomHardwareRow(
                  component: component[index],
                  nameOfComponent: nameOfComponent[index],
                  index: index);
            },
          ),
          SizedBox(
            height: 33,
          ),
          PlaceSale(phone: phone),
          SizedBox(
            height: 25,
          ),
          DescribeForm(content: phone.parameters.toString()),
        ],
      ),
    );
  }
}

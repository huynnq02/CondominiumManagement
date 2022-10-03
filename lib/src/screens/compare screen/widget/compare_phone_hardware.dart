// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/src/screens/compare%20screen/widget/compare_hardware_row.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/system%20tab/custom_hardware_row_widget.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/system%20tab/describe_form.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class ComparePhoneHardwareTab extends StatelessWidget {
  Phone phone;
  ComparePhoneHardwareTab({Key? key, required this.phone}) : super(key: key);
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
  Future<void>? _launched;
  Future<void> _launchInWebViewOrVC(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: component.length,
            itemBuilder: (BuildContext context, int index) {
              return CompareHardwareRow(
                  component: component[index],
                  nameOfComponent: nameOfComponent[index],
                  index: index);
            },
          ),
        ),
        SizedBox(
          height: 33,
        ),
        SizedBox(
          width: 160,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.Orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              _launched = _launchInWebViewOrVC(phone.link.toString());
            },
            child: Text(
              'Tới nơi bán',
              style: AppTextStyle.nunitoSize13.copyWith(
                  color: AppColors.White,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 23,
        ),
      ],
    );
  }
}

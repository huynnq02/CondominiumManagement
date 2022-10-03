// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/screens/compare%20screen/widget/compare_phone_hardware.dart';
import 'package:untitled/src/screens/compare%20screen/widget/phone_detail.dart';
import 'package:untitled/src/screens/compare%20screen/widget/widget_compare_null.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import '../../../providers/compare_provider.dart';
import '../../main screen/widgets/information.dart';
import '../../search screen/widget/other_phone.dart';

class CompareDetailPhone extends StatefulWidget {
  CompareDetailPhone({Key? key}) : super(key: key);

  @override
  State<CompareDetailPhone> createState() => _CompareDetailPhoneState();
}

class _CompareDetailPhoneState extends State<CompareDetailPhone> {
  @override
  void initState() {
    //refresh the page here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CompareProvider compareProvider;
    compareProvider = Provider.of<CompareProvider>(context, listen: true);
    return Container(
        // child: PhoneDetail(),
        child: Column(
      children: [
        Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: AppColors.LightBlue),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: compareProvider.phone1 != null
                      ? PhoneDetail(
                          number: 1,
                          phone: compareProvider.phone1!,
                        )
                      : WidgetCompareNull(),
                ),
                Container(
                  width: 2.5,
                  color: Color.fromARGB(255, 190, 190, 190),
                ),
                Expanded(
                  child: compareProvider.phone2 != null
                      ? PhoneDetail(
                          number: 2,
                          phone: compareProvider.phone2!,
                        )
                      : WidgetCompareNull(),
                ),
              ],
            )),
        Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.White,
              border: Border.all(width: 0.5, color: AppColors.LightBlue),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                    child: compareProvider.phone1 != null
                        ? ComparePhoneHardwareTab(
                            phone: compareProvider.phone1!,
                          )
                        : WidgetCompareNull()),
                Container(
                  width: 2.5,
                  color: Color.fromARGB(255, 190, 190, 190),
                ),
                Expanded(
                  child: compareProvider.phone2 != null
                      ? ComparePhoneHardwareTab(
                          phone: compareProvider.phone2!,
                        )
                      : WidgetCompareNull(),
                  // ComparePhoneHardwareTab()
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OtherPhone(),
        ),
        SizedBox(
          height: 18,
        ),
        Information(),
      ],
    ));
  }
}

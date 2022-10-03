import 'package:flutter/material.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/src/screens/compare%20screen/select_phone.dart';
import 'package:untitled/src/screens/compare%20screen/widget/compare_detail_phone.dart';

import '../../../utils/app_constant/app_colors.dart';
import '../../../utils/app_constant/app_text_style.dart';
import '../dashboard/menu_dashboard.dart';

class CompareScreen extends StatefulWidget {
  Phone phone;
  CompareScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.Blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: AppColors.White,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Image.asset('assets/logo.png'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MenuDashboard()),
                );
              },
              icon: const Icon(
                Icons.menu_outlined,
                color: AppColors.LightBlue,
                size: 35,
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          height: 10,
        ),
        // Padding(
        //   child: Image.asset('assets/advertisement.png'),
        //   padding: const EdgeInsets.only(top: 8, bottom: 18),
        // ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'So sánh sản phẩm',
                  style: AppTextStyle.nunitoSize13
                      .copyWith(fontSize: 17, fontWeight: FontWeight.w900),
                ),
                GestureDetector(
                    onTap: (() {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => SelectPhoneCompare(),
                        ),
                      )
                          .then((value) {
                        setState(() {});
                      });
                    }),
                    child: Container(
                      width: 170,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.LightBlue)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.add_outlined,
                            color: AppColors.LightBlue,
                            size: 15,
                          ),
                          Expanded(
                            child: Text(
                              'Chọn sản phẩm so sánh',
                              style: AppTextStyle.nunitoSize13.copyWith(
                                  fontSize: 12, color: AppColors.LightBlue),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            )),
        CompareDetailPhone()
      ])),
    );
  }
}

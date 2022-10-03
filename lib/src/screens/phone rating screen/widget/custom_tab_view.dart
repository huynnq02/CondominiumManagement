// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/comment_tab.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/custom_button.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/custom_pie_chart.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/system%20tab/phone_hardware_tab.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../models/phone.dart';
import '../../../providers/filter_comment_provider.dart';
import '../../../providers/paginator_provider.dart';

class CustomTabView extends StatefulWidget {
  Phone phone;
  CustomTabView({Key? key, required this.phone}) : super(key: key);

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView>
    with TickerProviderStateMixin {
  int _value = 0;

  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.LightBlue1,
            spreadRadius: -5,
            blurRadius: 4,
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: Card(
        color: AppColors.White,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 15,
                bottom: 42,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    value: 0,
                    groupValue: _value,
                    title: 'Đánh giá',
                    onChanged: (value) => setState(() {
                      _value = value!;
                      _tabController.animateTo(value);
                    }),
                  ),
                  CustomButton(
                    value: 1,
                    groupValue: _value,
                    title: 'Cấu hình',
                    onChanged: (value) => setState(() {
                      _value = value!;
                      _tabController.animateTo(value);
                    }),
                  ),
                ],
              ),
            ),
            _value == 0
                ? MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (BuildContext context) {
                        return PaginatorProvider();
                      }),
                      ChangeNotifierProvider(create: (BuildContext context) {
                        return FilterCommentProvider();
                      })
                    ],
                    child: CommentTab(phone: widget.phone),
                  )
                : PhoneHardwareTab(phone: widget.phone),
          ],
        ),
      ),
    );
  }
}

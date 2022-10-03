// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/filter_provider.dart';
import 'package:untitled/src/providers/repository_provider.dart';

import 'package:untitled/src/widget/filter_radio_button.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../models/phone.dart';

class Filter extends StatefulWidget {
  List<Phone> list;
  Filter({Key? key, required this.list}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterProvider>(context, listen: false);
    final providerPhone =
        Provider.of<RepositoryProvider>(context, listen: false);
    final component = <String>[
      'Màn hình',
      'Camera',
      'Hệ điều hành',
      'Pin, Sạc',
      'Thiết kế',
      'Bộ nhớ trong',
      'Giá',
      'Hiệu suất',
    ];
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/filter.svg'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Lọc theo tính năng',
                    style: AppTextStyle.nunitoBoldSize14.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      child: GestureDetector(
                        onTap: () {
                          if (provider.overlayEntry != null) {
                            print('3');
                            provider.overlayEntry!.remove();
                            provider.turnOff();
                          }
                        },
                        child: SvgPicture.asset('assets/cancel.svg'),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: component.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                return FilterRadioButton(
                  filter: component[index],
                  index: index,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 160,
              height: 42,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppColors.Orange),
                onPressed: () {
                  setState(() {
                    if (provider.overlayEntry != null) {
                      provider.applyFilter(widget.list, context);
                      provider.overlayEntry!.remove();
                      provider.turnOff();
                    }
                  });
                },
                child: Text(
                  'Hoàn tất',
                  style: AppTextStyle.nunitoSize13.copyWith(
                      color: AppColors.White,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

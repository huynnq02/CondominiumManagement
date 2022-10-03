import 'package:flutter/material.dart';
import 'package:untitled/src/screens/compare%20screen/widget/item_gridview_compare.dart';

import '../../../models/phone.dart';

class CustomGridviewCompare extends StatefulWidget {
  List<Phone> listPhone;
  CustomGridviewCompare({Key? key, required this.listPhone}) : super(key: key);

  @override
  State<CustomGridviewCompare> createState() => _CustomGridviewCompareState();
}

class _CustomGridviewCompareState extends State<CustomGridviewCompare> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: GridView.builder(
          itemCount: widget.listPhone.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.52,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return ItemGridViewCompare(phone: widget.listPhone[index]);
          },
        ));
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/src/screens/main%20screen/widgets/search_history_item.dart';
import 'package:untitled/src/screens/search%20screen/seach_result_screen.dart';
import 'package:untitled/src/widget/search_item.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../models/phone.dart';

class SearchAppBar extends StatefulWidget {
  List<Phone> listPhone;
  SearchAppBar({Key? key, required this.listPhone}) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController controller;
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late bool isShow;
  List<Phone> listResultPhone = [];
  @override
  void initState() {
    controller = TextEditingController();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        isShow = true;
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)!.insert(_overlayEntry);
      } else {
        // controller.clear();
        _overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    if (listResultPhone.isEmpty) listResultPhone = widget.listPhone;
    return OverlayEntry(
        builder: (context) => Positioned(
            width: size.width + 40,
            child: CompositedTransformFollower(
              link: this._layerLink,
              showWhenUnlinked: false,
              offset: Offset(-30, size.height + 8.0),
              child: Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
                elevation: 4.0,
                child: Container(
                  height: 250,
                  child: ListView.builder(
                    itemCount: listResultPhone.length,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return SearchItem(
                        phone: listResultPhone[index],
                        inputText: listResultPhone[index].name,
                      );
                    },
                  ),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: TextField(
        onChanged: (value) {
          setState(() {
            listResultPhone = widget.listPhone
                .where((element) =>
                    element.name!.toUpperCase().contains(value.toUpperCase()))
                .toList();
          });
        },
        showCursor: true,
        focusNode: _focusNode,
        style: GoogleFonts.roboto(
          color: AppColors.DarkBlue,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.red)),
          isDense: true,
        ),
      ),
    );
  }
}

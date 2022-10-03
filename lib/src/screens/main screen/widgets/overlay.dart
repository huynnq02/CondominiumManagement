// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/src/screens/main%20screen/widgets/search_history_item.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../models/phone.dart';

class OverlayTextField extends StatefulWidget {
  List<Phone> listPhone;

  OverlayTextField({Key? key, required this.listPhone}) : super(key: key);

  @override
  _OverlayTextFieldState createState() => _OverlayTextFieldState();
}

class _OverlayTextFieldState extends State<OverlayTextField> {
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
        _overlayEntry = _createOverlayEntry(false, '');
        Overlay.of(context)!.insert(_overlayEntry);
      } else {
        // controller.clear();
        _overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry(bool hasText, String text) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    listResultPhone = widget.listPhone
        .where((element) =>
            element.name!.toUpperCase().contains(text.toUpperCase()))
        .toList();
    return OverlayEntry(
        builder: (context) => Positioned(
            width: size.width + 40,
            child: CompositedTransformFollower(
              link: this._layerLink,
              showWhenUnlinked: false,
              offset: Offset(-42, size.height),
              child: Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
                elevation: 4.0,
                child: SizedBox(
                    height: 290,
                    child: ListView.builder(
                      itemCount: listResultPhone.length,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return SearchHistoryItem(
                            inputText: listResultPhone[index].name,
                            hasText: hasText,
                            listResultPhone: listResultPhone);
                      },
                    )
                    // : ListView.builder(
                    //     itemCount: ,
                    //     padding: EdgeInsets.zero,
                    //     shrinkWrap: true,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return SearchHistoryItem(
                    //           inputText: listResultPhone[index].name,
                    //           hasText: hasText,
                    //           listResultPhone: listResultPhone);
                    //     },
                    //   ),
                    ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CompositedTransformTarget(
        link: this._layerLink,
        child: TextField(
          onChanged: (value) {
            setState(() {
              if (!value.isEmpty) {
                _overlayEntry.remove();
                _overlayEntry = _createOverlayEntry(true, value);
                Overlay.of(context)!.insert(_overlayEntry);
              } else {
                _overlayEntry.remove();
                value = '';
                _overlayEntry = _createOverlayEntry(false, '');
                Overlay.of(context)!.insert(_overlayEntry);
              }
            });
          },
          focusNode: _focusNode,
          style: GoogleFonts.roboto(
            color: AppColors.DarkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }
}

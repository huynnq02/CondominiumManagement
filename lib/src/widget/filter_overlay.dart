// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/filter_provider.dart';
import 'package:untitled/src/widget/filter.dart';

import '../models/phone.dart';

class FilterOverlay extends StatefulWidget {
  List<Phone> listPhone;
  FilterOverlay({Key? key, required this.listPhone}) : super(key: key);

  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
  }

  OverlayEntry createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width + 300,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8.0),
          child: Filter(list: widget.listPhone),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterProvider>(context, listen: false);
    return CompositedTransformTarget(
      link: this._layerLink,
      child: GestureDetector(
        onTap: () {
          if (!provider.isShow) {
            provider.overlayEntry = createOverlayEntry();
            Overlay.of(context)!.insert(provider.overlayEntry!);
            print('1');
          } else {
            if (provider.overlayEntry != null) {
              print('2');
              provider.overlayEntry!.remove();
            }
          }
          Provider.of<FilterProvider>(context, listen: false).turnOff();
        },
        child: SvgPicture.asset(
          'assets/filter.svg',
          width: 27,
          height: 27,
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/review.dart';
import 'package:untitled/src/screens/phone%20rating%20screen/widget/comment%20tab/filter_comment.dart';


import '../../../../../utils/app_constant/app_text_style.dart';
import '../../../../providers/filter_comment_provider.dart';

class FilterOverlayComment extends StatefulWidget {
  List<Review> list;
  String idProduct;
  FilterOverlayComment({Key? key, required this.list, required this.idProduct})
      : super(key: key);

  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlayComment> {
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
  }

  OverlayEntry createOverlayEntry() {
    final provider = Provider.of<FilterCommentProvider>(context, listen: false);
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(builder: (context) {
      return ChangeNotifierProvider.value(
        value: provider,
        child: Positioned(
          width: size.width+300  ,
          child: CompositedTransformFollower(
            link: this._layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 8.0),
            child: FilterComment(
              idProduct: widget.idProduct,
              lisReview: widget.list,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterCommentProvider>(context, listen: false);
    return CompositedTransformTarget(
      link: this._layerLink,
      child: GestureDetector(
          onTap: () {
            if (!provider.isShow) {
              provider.overlayEntry = createOverlayEntry();
              Overlay.of(context)!.insert(provider.overlayEntry!);
         
            } else {
              if (provider.overlayEntry != null) {
        
                provider.overlayEntry!.remove();
              }
            }
            provider.turnOff();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/filter.svg',
                width: 27,
                height: 27,
              ),
              Text(
                'Lọc bình luận',
                style: AppTextStyle.nunitoBoldSize14.copyWith(
                  fontSize: 15,
                ),
              ),
            ],
          )),
    );
  }
}

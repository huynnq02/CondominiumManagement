import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/favorite_provider.dart';
import 'package:untitled/src/screens/dashboard/product_manage/widget/fav_screen_custom_rating_bar.dart';
import 'package:untitled/src/widget/custom_image.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../../models/phone.dart';

class FavScreenCustomWidget extends StatefulWidget {
  Phone phone;
  FavScreenCustomWidget({Key? key, required this.phone}) : super(key: key);

  @override
  State<FavScreenCustomWidget> createState() => _FavScreenCustomWidgetState();
}

class _FavScreenCustomWidgetState extends State<FavScreenCustomWidget> {
  late FavoriteProvider provider;
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<FavoriteProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: CustomImage(
                imageUrl: widget.phone.linkImage.toString(),
                size: esize.belowmedium),
            color: AppColors.LightGrey,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.LightBlue1,
                    spreadRadius: -5,
                    blurRadius: 4,
                    offset: Offset(0, 1), // Shadow position
                  ),
                ],
              ),
              height: 60,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                          child: GestureDetector(
                        onLongPress: () {
                          //Xử lý nhấn giữ để hiển thị tên sản phẩm
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    content: Row(
                                      children: [
                                        Container(
                                          child: CustomImage(
                                              imageUrl: widget.phone.linkImage
                                                  .toString(),
                                              size: esize.belowmedium),
                                          color: AppColors.LightGrey,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.phone.name.toString(),
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.nunitoBoldSize14
                                              .copyWith(
                                                  fontSize: 12,
                                                  color: AppColors.DarkGrey),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ));
                        },
                        child: SizedBox(
                            width: 160,
                            child: Text(
                              widget.phone.name.toString(),
                              textAlign: TextAlign.center,
                              style: AppTextStyle.nunitoBoldSize14.copyWith(
                                  fontSize: 12, color: AppColors.DarkGrey),
                              overflow: TextOverflow.ellipsis,
                            )),
                      )),
                      const VerticalDivider(
                        width: 2,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.phone.statistical!.overallScore.toString(),
                        style: AppTextStyle.nunitoBoldSize14
                            .copyWith(fontSize: 12, color: AppColors.DarkGrey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const VerticalDivider(
                        width: 2,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.insertFav(widget.phone.id.toString());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text(provider.message.toString())));
                        },
                        child: SvgPicture.asset(
                          'assets/compare.svg',
                          width: 27,
                          height: 27,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

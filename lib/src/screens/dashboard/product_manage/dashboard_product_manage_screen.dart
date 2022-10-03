import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/favorite_provider.dart';
import 'package:untitled/src/providers/manage_paginator_provider.dart';
import 'package:untitled/src/screens/dashboard/product_manage/widget/custom_datatable.dart';
import 'package:untitled/src/screens/dashboard/product_manage/widget/textfield_search.dart';
import 'package:untitled/src/screens/dashboard/widget/appbar_logo.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../../utils/app_constant/app_text_style.dart';
import '../../../models/phone.dart';
import '../../../providers/fav_paginator_provider.dart';
import '../../search screen/widget/widget_load.dart';
import 'add_fav_product_screen.dart';

class DashBoardProductManageScreen extends StatefulWidget {
  List<Phone> listPhone;

  DashBoardProductManageScreen({Key? key, required this.listPhone})
      : super(key: key);

  @override
  State<DashBoardProductManageScreen> createState() =>
      _DashBoardProductManageScreenState();
}

class _DashBoardProductManageScreenState
    extends State<DashBoardProductManageScreen> {
  late FavoriteProvider favoriteProvider;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<String> listId = [];
  List<Phone> listPhoneFav = [];
  String? valueText;

  @override
  void initState() {
    super.initState();
  }

  delete() async {
    await favoriteProvider.deletefav(listId);
    await favoriteProvider.getFav();
    listId = [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBarLogo(listPhone: widget.listPhone)),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
              ),
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border:
                              Border.all(width: 0.5, color: AppColors.Blue)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: const EdgeInsets.all(10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    border: Border.all(
                                        width: 0.5, color: AppColors.Blue)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return ChangeNotifierProvider(
                                                  create:
                                                      (BuildContext context) {
                                                    return FavPaginatorProvider();
                                                  },
                                                  child:
                                                      AddFavoriteProductScreen());
                                            })).then(
                                                (value) => setState(() {}));
                                          },
                                          child: Text(
                                            'Thêm mới',
                                            style: AppTextStyle.nunitoBoldSize14
                                                .copyWith(
                                                    color: AppColors.Black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            listId.isNotEmpty ? delete() : "";

                                            favoriteProvider.listSearchPhoneFav;
                                            setState(() {});
                                            listId.isNotEmpty
                                                ? ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Đang xóa sản phẩm... ')))
                                                : ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Vui lòng chọn sản phẩm ')));
                                          },
                                          child: Text(
                                            'Xóa',
                                            style: AppTextStyle.nunitoSize13
                                                .copyWith(
                                                    color: AppColors.Grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ])),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 0.5, color: AppColors.Blue)),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextFieldSearch(
                              valueText: (val) => valueText = val,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            MaterialButton(
                              height: 45,
                              minWidth: 100,
                              color: AppColors.Blue,
                              onPressed: () {
                                setState(() {
                                  favoriteProvider.searchPhoneFav(
                                      text: valueText.toString(),
                                      listPhone: favoriteProvider.listPhoneFav);
                                  listPhoneFav =
                                      favoriteProvider.listSearchPhoneFav;
                                });
                              },
                              child: const Text(
                                'Tìm kiếm',
                                style: TextStyle(color: AppColors.White),
                              ),
                            ),
                            // WidgetDropdown(
                            //   listPhoneFav: listPhoneFav,
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: FutureBuilder(
                              future: favoriteProvider.getFav(),
                              builder: (context, snapshot) {
                                listPhoneFav = favoriteProvider.listPhoneFav;
                                return snapshot.hasData ||
                                        listPhoneFav.isNotEmpty
                                    ? ChangeNotifierProvider(
                                        create: (BuildContext context) {
                                          return ManagePaginatorProvider();
                                        },
                                        child: listPhoneFav.isEmpty
                                            ? const Center(
                                                child: Text('Chưa có dữ liệu'),
                                              )
                                            : CustomDataTable(
                                                check: false,
                                                listId: (value) =>
                                                    listId = value,
                                                listFavPhone: favoriteProvider
                                                        .listSearchPhoneFav
                                                        .isEmpty
                                                    ? favoriteProvider
                                                        .listPhoneFav
                                                    : favoriteProvider
                                                        .listSearchPhoneFav,
                                                listAllPhone: widget.listPhone,
                                              ))
                                    : Container(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: const WidgetLoad());
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}

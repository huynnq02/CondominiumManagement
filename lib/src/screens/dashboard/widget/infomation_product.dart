// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/dashboard_paginator_provider.dart';
import 'package:untitled/src/screens/dashboard/product_manage/dashboard_product_manage_screen.dart';
import 'package:untitled/src/screens/dashboard/widget/custom_panginator.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';
import '../../../models/phone.dart';
import '../../../providers/favorite_provider.dart';
import '../../search screen/widget/widget_load.dart';

class InformationProduct extends StatefulWidget {
  final listId;

  InformationProduct({Key? key, required this.listId}) : super(key: key);

  @override
  State<InformationProduct> createState() => _InfomationProductState();
}

class _InfomationProductState extends State<InformationProduct> {
  late DashBoardPaginatorProvider paginatorProvider;
  late FavoriteProvider favoriteProvider;

  List<Phone> selectPhone = [];
  List<String> listString = [];
  bool check = false;
  @override
  void initState() {
    super.initState();
    listString = [];
    favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
    check = false;
  }

  deleteFav() async {
    await favoriteProvider.deletefav(listString);
    await favoriteProvider.getFav();
    listString = [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
    paginatorProvider =
        Provider.of<DashBoardPaginatorProvider>(context, listen: true);

    List<DataColumn> _createColumns() {
      return [
        DataColumn(
            label: Expanded(
                child: Text(
          'STT',
          style: AppTextStyle.nunitoBoldSize14.copyWith(color: AppColors.White),
        ))),
        DataColumn(
            label: Expanded(
                child: Text('Tên sản phẩm',
                    style: AppTextStyle.nunitoBoldSize14
                        .copyWith(color: AppColors.White))))
      ];
    }

    List<DataRow> _createRows(int state) {
      return favoriteProvider.listPhoneFav
          .skip(state * 5)
          .take(5)
          .map((e) => DataRow(
                  selected: selectPhone.contains(e),
                  onSelectChanged: (isChecked) {
                    setState(() {
                      check == false
                          ? listString = []
                          : listString = listString;
                      final addList = isChecked != null && isChecked;
                      addList ? selectPhone.add(e) : selectPhone.remove(e);
                      addList
                          ? listString.add(e.id.toString())
                          : listString.remove(e.id.toString());
                      check = true;
                      widget.listId(listString);
                    });
                  },
                  cells: [
                    DataCell(Text((favoriteProvider.listPhoneFav.indexOf(e) + 1)
                        .toString())),
                    DataCell(Text(e.name.toString())),
                  ]))
          .toList();
    }

    return FutureBuilder(
        future: favoriteProvider.getFav(),
        builder: (context, snapshot) {
          return snapshot.hasData || favoriteProvider.listPhoneFav.isNotEmpty
              ? FutureBuilder(
                  future: paginatorProvider
                      .fetchPhone(favoriteProvider.listPhoneFav),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return snapshot.hasData
                        ? Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color: AppColors.LightBlue, width: 0.5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Thông tin sản phẩm',
                                      style: AppTextStyle.nunitoBoldSize14
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 55,
                                      height: 28,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.White,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1, color: AppColors.Red),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          listString.isNotEmpty
                                              ? deleteFav()
                                              : "";
                                          favoriteProvider.listSearchPhoneFav;
                                          listString.isNotEmpty
                                              ? ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Đang xóa sản phẩm... ')))
                                              : ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Vui lòng chọn sản phẩm ')));
                                          setState(() {});
                                        },
                                        child: Text(
                                          'Xóa',
                                          style: AppTextStyle.nunitoSize13
                                              .copyWith(
                                                  color: AppColors.Red,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 133,
                                      height: 28,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColors.Blue),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DashBoardProductManageScreen(
                                                listPhone: favoriteProvider
                                                    .listPhoneFav,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Xem Dashboard',
                                          style: AppTextStyle.nunitoSize13
                                              .copyWith(
                                                  fontSize: 11,
                                                  color: AppColors.White,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                favoriteProvider.listPhoneFav.isEmpty
                                    ? Center(
                                        child: Text(
                                          'Chưa có sản phẩm yêu thích.',
                                          style: AppTextStyle.nunitoBoldSize14
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: DataTable(
                                                headingRowColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            AppColors.Blue),
                                                columns: _createColumns(),
                                                rows: _createRows(
                                                    paginatorProvider.state -
                                                        1),
                                                dataRowHeight: 40,
                                                dataTextStyle: AppTextStyle
                                                    .nunitoBoldSize14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomPaginator(
                                            state: paginatorProvider.state,
                                            length: paginatorProvider
                                                .listSortPhone.length,
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          )
                        : Text("Chưa có sản phẩm yêu thích");
                  },
                )
              : const WidgetLoad();
        });
  }
}

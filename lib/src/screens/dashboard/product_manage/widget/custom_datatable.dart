import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/manage_paginator_provider.dart';
import 'package:untitled/src/screens/dashboard/product_manage/widget/paginator_manage.dart';
import 'package:untitled/src/screens/search%20screen/widget/widget_load.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import '../../../../../utils/app_constant/app_text_style.dart';
import '../../../../models/phone.dart';

class CustomDataTable extends StatefulWidget {
  late List<Phone> listFavPhone;
  final listId;
  bool check;
  List<Phone> listAllPhone;
  CustomDataTable(
      {Key? key,
      required this.check,
      required this.listId,
      required this.listAllPhone,
      required this.listFavPhone})
      : super(key: key);

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  ManagePaginatorProvider? paginatorProvider;

  List<Phone> listDataTable = [];
  List<Phone> selectPhone = [];
  List<String> listString = [];

  @override
  void initState() {
    super.initState();
    listString = [];
  }

  @override
  Widget build(BuildContext context) {
    paginatorProvider =
        Provider.of<ManagePaginatorProvider>(context, listen: true);
    paginatorProvider!.fetchPhone(widget.listFavPhone);
    List<DataColumn> _createColumns() {
      return [
        const DataColumn(
            label: Text(
          'Loại sản phẩm',
          style: TextStyle(color: AppColors.White),
        )),
        const DataColumn(
            label:
                Text('Tên sản phẩm', style: TextStyle(color: AppColors.White))),
        const DataColumn(
            label:
                Text('Nhà cung cấp', style: TextStyle(color: AppColors.White))),
        const DataColumn(
            label: Text('Đánh giá', style: TextStyle(color: AppColors.White)))
      ];
    }

    List<DataRow> _createRows(int state) {
      listDataTable = widget.listFavPhone;

      return listDataTable
          .skip(state * 5)
          .take(5)
          .map((e) => DataRow(
                  selected: selectPhone.contains(e),
                  onSelectChanged: (isChecked) {
                    setState(() {
                      widget.check == false
                          ? listString = []
                          : listString = listString;
                      final addList = isChecked != null && isChecked;
                      addList ? selectPhone.add(e) : selectPhone.remove(e);
                      addList
                          ? listString.add(e.id.toString())
                          : listString.remove(e.id.toString());
                      widget.check = true;
                      widget.listId(listString);
                    });
                  },
                  cells: [
                    const DataCell(Text('Điện thoại')),
                    DataCell(Text(e.name.toString())),
                    DataCell(Text(e.brand.toString())),
                    DataCell(Text(e.statistical!.overallScore.toString()))
                  ]))
          .toList();
    }

    return FutureBuilder(
        future: paginatorProvider!.fetchPhone(widget.listFavPhone),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.Blue),
                          columns: _createColumns(),
                          rows: _createRows(paginatorProvider!.state - 1),
                          dataRowHeight: 40,
                          dataTextStyle: AppTextStyle.nunitoBoldSize14
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    PaginatorManage(
                        length: paginatorProvider!.listSortPhone.length,
                        state: paginatorProvider!.state)
                  ],
                )
              : const WidgetLoad();
        });
  }
}

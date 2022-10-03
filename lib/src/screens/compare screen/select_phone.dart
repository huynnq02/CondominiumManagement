import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/screens/compare%20screen/widget/custom_gridview_compare.dart';

import '../../../utils/app_constant/app_colors.dart';
import '../../models/phone.dart';
import '../../providers/repository_provider.dart';

class SelectPhoneCompare extends StatefulWidget {
  SelectPhoneCompare({Key? key}) : super(key: key);

  @override
  State<SelectPhoneCompare> createState() => _SelectPhoneCompareState();
}

class _SelectPhoneCompareState extends State<SelectPhoneCompare> {
  final searchController = TextEditingController();
  RepositoryProvider? provider;
  List<Phone> listPhone = [];
  List<Phone> listSearch = [];
  searchPhone(String text) {
    listSearch = listPhone
        .where((element) =>
            element.name!.toUpperCase().contains(text.toUpperCase()))
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<RepositoryProvider>(context, listen: false);
    listPhone = provider!.phones;
    listSearch = listPhone;
  }

  String? valueText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.White,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset('assets/logo.png'),
          ),
          actions: const [
            Icon(
              Icons.menu_outlined,
              color: AppColors.LightBlue,
              size: 35,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  onChanged: ((value) {
                    setState(() {
                      valueText = value;
                      searchPhone(valueText.toString());
                    });
                  }),
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Nhập tên sản phẩm để tìm kiếm... ',
                    contentPadding: const EdgeInsets.all(5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.Blue,
                        width: 1,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.Blue, width: 0.5),
                    ),
                  ),
                )),
            CustomGridviewCompare(listPhone: listSearch)
          ]),
        ));
  }
}

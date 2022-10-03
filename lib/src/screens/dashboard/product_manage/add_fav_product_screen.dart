import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import 'package:untitled/src/screens/dashboard/product_manage/widget/custom_list_add_fav.dart';
import 'package:untitled/src/screens/dashboard/product_manage/widget/fav_screen_textfield.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import '../../../models/phone.dart';
import '../../../providers/fav_paginator_provider.dart';

class AddFavoriteProductScreen extends StatefulWidget {
  const AddFavoriteProductScreen({Key? key}) : super(key: key);

  @override
  State<AddFavoriteProductScreen> createState() =>
      _AddFavoriteProductScreenState();
}

class _AddFavoriteProductScreenState extends State<AddFavoriteProductScreen> {
  late RepositoryProvider provider;
  List<Phone> ListPhone = [];
  List<Phone> listSearch = [];
  String? valueSearch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<RepositoryProvider>(context, listen: false);
    provider.getPhones();
    ListPhone = provider.phones;
    listSearch = provider.phones;
  }

  @override
  Widget build(BuildContext context) {
    final providerPa =
        Provider.of<FavPaginatorProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {
            setState(() {
              Navigator.of(context).pop();
            });
          }),
          icon: const Icon(Icons.arrow_back),
          color: AppColors.DarkGrey,
        ),
        centerTitle: true,
        backgroundColor: AppColors.White,
        title: Text(
          'Thêm sản phẩm',
          style: AppTextStyle.nunitoSize13.copyWith(
            fontSize: 18,
            color: AppColors.Blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: AppColors.White,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                FAVScreenTextField(
                  valueSearch: (value) => valueSearch = value,
                ),
                const SizedBox(
                  height: 10,
                ),
                // const FavScreenDropDown(),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 140,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.Blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        ListPhone = listSearch
                            .where((element) => element.name
                                .toString()
                                .toUpperCase()
                                .contains(valueSearch.toString().toUpperCase()))
                            .toList();

                        providerPa.state = 1;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.search,
                          color: AppColors.White,
                          size: 25,
                        ),
                        Text(
                          'Tìm kiếm',
                          style: AppTextStyle.nunitoSize13.copyWith(
                              color: AppColors.White,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Sản phẩm',
                      style: AppTextStyle.nunitoBoldSize14
                          .copyWith(color: AppColors.Blue),
                    ),
                    Text(
                      'Điểm',
                      style: AppTextStyle.nunitoBoldSize14
                          .copyWith(color: AppColors.Blue),
                    ),
                  ],
                ),
                CustomListAddFav(
                  listPhone: ListPhone,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/providers/filter_provider.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import 'package:untitled/src/screens/search%20screen/widget/widget_body_search.dart';
import 'package:untitled/src/widget/filter.dart';

import 'package:untitled/src/widget/search_appbar.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../models/phone.dart';
import '../../providers/search_paginatior_provider.dart';
import '../../widget/filter_overlay.dart';

class SearchResultScreen extends StatefulWidget {
  List<Phone> listResultPhone;
  SearchResultScreen({required this.listResultPhone, Key? key})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  bool isSearching = false;
  late RepositoryProvider provider;

  Widget title() {
    return isSearching
        ? SearchAppBar(listPhone: provider.phones)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset('assets/logo.png'),
          );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<RepositoryProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                leading: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  child: FilterOverlay(listPhone: widget.listResultPhone),
                ),
                centerTitle: true,
                title: title(),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: GestureDetector(
                      child: !isSearching
                          ? SvgPicture.asset('assets/search.svg')
                          : Icon(
                              Icons.cancel,
                              color: AppColors.LightBlue,
                            ),
                      onTap: () {
                        setState(() {
                          isSearching = !isSearching;
                        });
                      },
                    ),
                  )
                ],
              ),
              body: ChangeNotifierProvider(
                  create: (BuildContext context) {
                    return SearchPaginatorProvider();
                  },
                  child: WidgetBodySearch(
                      listResultPhone: widget.listResultPhone)))),
    );
  }
}

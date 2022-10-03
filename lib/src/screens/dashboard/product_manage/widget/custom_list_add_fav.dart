import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/src/providers/fav_paginator_provider.dart';

import '../fav_screen_custom_paginator.dart';
import 'fav_screen_custom_widget.dart';

class CustomListAddFav extends StatefulWidget {
  List<Phone> listPhone;
  CustomListAddFav({Key? key, required this.listPhone}) : super(key: key);

  @override
  State<CustomListAddFav> createState() => _CustomListAddFavState();
}

class _CustomListAddFavState extends State<CustomListAddFav> {
  late FavPaginatorProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Phone> listPhone = [];
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<FavPaginatorProvider>(context, listen: true);
    provider.check == false ? provider.fetchPhone(widget.listPhone) : null;
    listPhone = provider.listSortPhone[provider.state - 1];
    return Column(
      children: [
        ListView.builder(
          itemCount: listPhone.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: ((context, index) {
            return FavScreenCustomWidget(
              phone: listPhone[index],
            );
          }),
        ),
        FavScreenCustomPaginator(
          state: provider.state,
          length: provider.listSortPhone.length,
        ),
      ],
    );
  }
}

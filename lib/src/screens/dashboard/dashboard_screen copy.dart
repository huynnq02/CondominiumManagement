import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/src/providers/dashboard_paginator_provider.dart';
import 'package:untitled/src/providers/favorite_provider.dart';
import 'package:untitled/src/providers/repository_provider.dart';
import 'package:untitled/src/screens/dashboard/widget/appbar_logo.dart';
import 'package:untitled/src/screens/dashboard/widget/infomation_product.dart';
import 'package:untitled/src/screens/dashboard/widget/nagative_comment.dart';
import 'package:untitled/src/screens/dashboard/widget/other_comments.dart';
import 'package:untitled/src/screens/dashboard/widget/positive_comments.dart';
import 'package:untitled/src/screens/dashboard/widget/total_comments.dart';
import 'package:untitled/src/screens/dashboard/widget/widget_column-chart.dart';
import 'package:untitled/src/screens/dashboard/widget/widget_line_chart.dart';
import 'package:untitled/src/screens/search%20screen/widget/widget_load.dart';
import '../main screen/widgets/information.dart';

class DashboardScreen2 extends StatefulWidget {
  DashboardScreen2({Key? key}) : super(key: key);

  @override
  State<DashboardScreen2> createState() => _DashboardScreenState2();
}

class _DashboardScreenState2 extends State<DashboardScreen2> {
  late RepositoryProvider provider;
  late FavoriteProvider providerFav;
  List<Phone> listPhone = [];
  List<Phone> listPhoneFav = [];
  List<String> listId = [];
  int total = 0;
  int negative = 0;
  int neutral = 0;
  int positive = 0;
  double overScore = 0;
  double average = 0;
  double percentNegative = 0, percentNeutral = 0, percentPositive = 0;
  late final Future? future;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RepositoryProvider>(context, listen: false);
    providerFav = Provider.of<FavoriteProvider>(context, listen: false);
    future = providerFav.getFav();
  }

  void getTotal() {
    total = 0;
    negative = 0;
    neutral = 0;
    positive = 0;
    average = 0;
    overScore = 0;
    percentNegative = 0;
    percentNeutral = 0;
    percentPositive = 0;
    statistical();

    total += positive + neutral + negative;
    average = overScore / listPhone.length;
    getPercent();
  }

  void statistical() {
    for (int i = 0; i < listPhone.length; i++) {
      positive += int.parse(listPhone[i].statistical!.totalPositive.toString());
      neutral += int.parse(listPhone[i].statistical!.totalNeutral.toString());
      negative += int.parse(listPhone[i].statistical!.totalNegative.toString());
      overScore +=
          double.parse(listPhone[i].statistical!.overallScore.toString());
    }
  }

  void getPercent() {
    percentPositive =
        double.parse(((positive * 100) / total).toStringAsFixed(2));

    percentNegative =
        double.parse(((negative * 100) / total).toStringAsFixed(2));
    percentNeutral = double.parse(((neutral * 100) / total).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    providerFav = Provider.of<FavoriteProvider>(context, listen: false);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBarLogo(listPhone: listPhone)),
        body: SingleChildScrollView(
            child: FutureBuilder(
          future: providerFav.getFav(),
          builder: (context, snapshot) {
            listPhone = providerFav.listPhoneFav;
            listPhone.isNotEmpty ? getTotal() : null;
            return snapshot.hasData || providerFav.listPhoneFav.isNotEmpty
                ? Column(
                    children: [
                      Row(children: [
                        Expanded(
                            child: GestureDetector(
                                onTapDown: ((details) {
                                  setState(() {});
                                }),
                                child: TotalComments(total: average))),
                        Expanded(
                            child: positiveComments(positive: percentPositive))
                      ]),
                      Row(
                        children: [
                          Expanded(
                            child: NagativeComments(
                              nagative: percentNegative,
                            ),
                          ),
                          Expanded(
                              child: OtherComments(neutral: percentNeutral))
                        ],
                      ),
                      ChangeNotifierProvider(
                          create: (BuildContext context) {
                            return DashBoardPaginatorProvider();
                          },
                          child: InformationProduct(
                            listId: (value) => listId = value,
                          )),
                      WidgetColumnChart(
                        listPhone: listPhone,
                      ),
                      WidgetLineChart(),
                      Information(),
                    ],
                  )
                : WidgetLoad();
          },
        )));
  }
}

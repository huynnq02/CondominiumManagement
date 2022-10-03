// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/src/models/phone.dart';
import '../../../../utils/app_constant/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../utils/app_constant/app_text_style.dart';
import '../../../providers/favorite_provider.dart';

class WidgetLineChart extends StatefulWidget {
  WidgetLineChart({
    Key? key,
  }) : super(key: key);

  @override
  State<WidgetLineChart> createState() => _WidgetLineChartState();
}

class _WidgetLineChartState extends State<WidgetLineChart> {
  late FavoriteProvider providerFav;
  List<ChartData> chartData = [
    ChartData('15/3', 7.7),
    ChartData('16/3', 6.3),
    ChartData('17/3', 8.0),
    ChartData('18/3', 5.0),
    ChartData('19/3', 8.3),
    ChartData('20/3', 6.5),
    ChartData('21/3', 7.0),
  ];
  List<Phone> listPhone = [];
  datachart() {
    chartData = [];
    for (int i = 0; i < listPhone.length; i++) {
      {
        chartData.add(ChartData(listPhone[i].datePreproc.toString(),
            double.parse(listPhone[i].statistical!.overallScore.toString())));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    providerFav = Provider.of<FavoriteProvider>(context, listen: false);
    listPhone = providerFav.listPhoneFav;
  }

  @override
  Widget build(BuildContext context) {
    datachart();
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.LightBlue, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Thống kê điểm số',
                  style: AppTextStyle.nunitoBoldSize14.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    Container(
                        height: 300,
                        width: 500,
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <ChartSeries>[
                              LineSeries<ChartData, String>(
                                  markerSettings: const MarkerSettings(
                                    width: 10,
                                    height: 10,
                                    color: AppColors.Blue,
                                    isVisible: true,
                                  ),
                                  pointColorMapper: (datum, index) =>
                                      AppColors.Blue,
                                  color: AppColors.Blue,
                                  dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      margin: const EdgeInsets.all(10),
                                      showCumulativeValues: true,
                                      color: AppColors.Blue,
                                      textStyle: AppTextStyle.nunitoBoldSize14
                                          .copyWith(
                                              color: AppColors.White,
                                              fontSize: 12)),
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y)
                            ]))
                  ]))),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
